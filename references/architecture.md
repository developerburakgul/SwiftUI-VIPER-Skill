# Architecture Reference

## Modified VIPER Pattern

This is NOT classic VIPER. Key differences:

```
┌─────────────────────────────────────────────────────────────┐
│                    CoreBuilder (struct)                       │
│  - Factory: build method for each module                     │
│  - Injects CoreInteractor and CoreRouter                     │
│  - Creates Presenter, passes it to View                      │
└─────────────────┬───────────────────────────────────────────┘
                  │ creates
┌─────────────────▼───────────────────────────────────────────┐
│              {Module}Presenter (ObservableObject class)       │
│  - Receives: interactor + router + entity                    │
│  - UI State (@Published private(set) var)                    │
│  - User action handler                                       │
│  - Fetches data through interactor protocol                  │
│  - Navigates through router protocol                         │
└──────┬──────────────────────────────────┬───────────────────┘
       │ uses                             │ uses
┌──────▼──────────────┐    ┌──────────────▼───────────────────┐
│ {Module}Interactor   │    │ {Module}Router                   │
│ (protocol)           │    │ (protocol)                       │
│                      │    │                                  │
│ extension            │    │ extension                        │
│ CoreInteractor:      │    │ CoreRouter:                      │
│   {Module}Interactor │    │   {Module}Router                 │
└──────────────────────┘    └──────────────────────────────────┘
```

> Tam proje klasör yapısı için SKILL.md Workflow 1'e bak.

## SPM Dependencies

| Package | Version | Modules | Usage |
|---------|---------|---------|-------|
| **BurakKit** | 0.1.3 | `DependencyContainer` | DI container for resolving managers |
| | | `DynamicColor` | Theme-aware colors (`@DynamicColor`), `ThemeStore`, `AppTheme`, `Color.init(hex:)` |
| **SwiftfulRouting** | 6.0.0+ | — | Navigation (`RouterView`, `AnyRouter`, `.showScreen`) |

## CoreBuilder Rules

- **Struct**, not class
- Single shared instance — creates ALL views
- Every module has a factory method: `func {moduleName}Screen(router:) -> some View`
- Factory method creates Presenter with interactor + CoreRouter + entity
- CoreRouter is created inline: `CoreRouter(router: router, builder: self)`

```swift
@MainActor
struct CoreBuilder {
    let interactor: CoreInteractor

    func someScreen(router: Router, entity: SomeEntity = SomeEntity()) -> some View {
        SomeScreen(
            presenter: SomePresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self),
                entity: entity
            )
        )
    }
}
```

## CoreInteractor Rules

- **Struct**, not class
- Resolves ALL managers from DependencyContainer (BurakKit)
- Each module defines a protocol for what it needs
- CoreInteractor conforms via extension
- Methods are thin wrappers — delegate to managers

```swift
@MainActor
struct CoreInteractor {
    private let authManager: AuthManager
    // ... other managers

    init(container: DependencyContainer) {
        self.authManager = container.resolve(AuthManager.self)!
        // ... resolve others
    }
}
```

## CoreRouter Rules

- **Struct**, not class
- Holds `Router` (from SwiftfulRouting) + `CoreBuilder`
- Each module defines a protocol for navigation it needs
- CoreRouter conforms via extension
- Navigation uses `router.showScreen(.push/.sheet/.fullScreenCover)`

```swift
@MainActor
struct CoreRouter {
    let router: Router
    let builder: CoreBuilder

    func showSomeScreen(entity: SomeEntity) {
        router.showScreen(.push) { router in
            builder.someScreen(router: router, entity: entity)
        }
    }
}
```

## Presenter Rules

- `ObservableObject` and `@MainActor`
- Receives: `interactor` (protocol), `router` (protocol), `entity` (struct)
- `interactor` and `router` are `private let`
- `entity` is `private let`
- State properties are `@Published private(set) var`
- Actions follow `func onXxxPressed()` or `func didXxx()` naming
- Computed properties in separate extension

```swift
@MainActor
class SomePresenter: ObservableObject {
    private let interactor: SomeInteractor
    private let router: SomeRouter
    private let entity: SomeEntity

    // MARK: - Published Properties
    @Published private(set) var items: [SomeModel] = []
    @Published private(set) var isLoading: Bool = true

    init(interactor: SomeInteractor, router: SomeRouter, entity: SomeEntity) {
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    // MARK: - Actions
    func onItemPressed(_ item: SomeModel) {
        router.showDetailScreen(entity: DetailEntity(item: item))
    }
}

// MARK: - Computed Properties
extension SomePresenter {
    // computed properties here
}
```

## Interactor Protocol Rules

- Always `@MainActor` protocol
- Minimum interface — only methods this module needs
- Conform via `extension CoreInteractor: {Module}Interactor { }`

```swift
@MainActor
protocol SomeInteractor {
    func fetchItems() async throws -> [SomeModel]
    var currentUser: UserModel? { get }
}

extension CoreInteractor: SomeInteractor { }
```

## Router Protocol Rules

- Always `@MainActor` protocol
- Group: Segues, Modals, Alerts (with MARK comments)
- Conform via `extension CoreRouter: {Module}Router { }`

```swift
@MainActor
protocol SomeRouter {
    // MARK: - Segues
    func showDetailScreen(entity: DetailEntity)

    // MARK: - Modals
    func dismissModal()
    func dismissScreen()

    // MARK: - Alerts
    func showAlert(error: Error)
}

extension CoreRouter: SomeRouter { }
```

## Entity Rules

- Plain struct — parameters passed from another module
- Created in CoreBuilder factory method
- Passed to Presenter, NOT to View

```swift
struct SomeEntity {
    let userId: String
    let productName: String
}
```

## Screen (View) Rules

- `@StateObject var presenter` (NOT @State)
- View only calls presenter methods, NO business logic
- `.task { }` for async data loading
- `#Preview` with DevPreview.shared.container
- Suffix is `Screen`, not `View`

```swift
struct SomeScreen: View {
    @StateObject var presenter: SomePresenter

    var body: some View {
        contentView
            .task {
                await presenter.loadData()
            }
    }

    private var contentView: some View {
        Text("Hello")
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    RouterView { router in
        builder.someScreen(router: router)
    }
}
```

## Build Configuration

3 build configs: Mock, Dev, Prod

```swift
enum BuildConfiguration {
    case mock(isSignedIn: Bool), dev, prod

    func configure() {
        switch self {
        case .mock: break  // No Firebase
        case .dev:  // Dev Firebase plist
        case .prod: // Prod Firebase plist
        }
    }
}
```

## DI Flow

```
AppDelegate.didFinishLaunching
  → BuildConfiguration selected (#if MOCK / DEV / PROD)
  → Dependencies(config:) creates all managers
  → Registers in DependencyContainer (from BurakKit)
  → CoreBuilder(interactor: CoreInteractor(container:))
  → builder.appView() → Window
```
