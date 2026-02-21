# Patterns Reference

## Subview Pattern

Complex UI parts of a screen are separated as **Subviews**. Two types:

### ScopedSubview (Screen-Specific)

Written as `extension` of the parent Screen. Entity, Binding, Config are namespaced.

```
Modules/{ModuleName}/Subviews/{SubviewName}/
├── {SubviewName}.swift              # View + Action enum (extension of Screen)
└── Entity/
    ├── {SubviewName}Entity.swift    # Entity = Binding + Config
    ├── {SubviewName}Binding.swift   # Two-way state (Equatable)
    └── {SubviewName}Config.swift    # One-way config (Equatable)
```

**3 Components:**
1. **Config** → `Equatable` struct, data set from outside, subview CANNOT modify (`let`)
2. **Binding** → `Equatable` struct, modifiable from BOTH outside and inside (`@Binding`)
3. **Action** → `enum`, single `onAction` closure instead of multiple closures

**View must conform to `Equatable`** with manual `==` implementation.

```swift
extension SomeScreen {
    struct SomeSubview: View, @MainActor Equatable {
        enum Action {
            case didTapText
        }

        @Binding var binding: SomeSubviewEntity.Binding
        let config: SomeSubviewEntity.Config
        let onAction: (Action) -> Void

        var body: some View { ... }

        static func == (lhs: SomeSubview, rhs: SomeSubview) -> Bool {
            lhs.binding == rhs.binding && lhs.config == rhs.config
        }
    }
}
```

### CommonSubview (Reusable)

Standalone struct under `Components/Views/`. Same Entity/Binding/Config pattern but NOT namespaced.

```swift
struct SharedInputView: View, @MainActor Equatable {
    enum Action { case didTapSubmit }

    @Binding var binding: SharedInputViewEntity.Binding
    let config: SharedInputViewEntity.Config
    let onAction: (Action) -> Void
    // ...
}
```

### Connecting Subview to Presenter

Presenter owns the subview entity. Screen passes binding + config to subview.

```swift
// In Presenter:
var someSubviewEntity = SomeSubviewEntity(
    binding: .init(),
    config: .init()
)

func handleSomeSubviewAction(_ action: SomeScreen.SomeSubview.Action) {
    switch action {
    case .didTapText:
        // handle
    }
}

// In Screen:
SomeSubview(
    binding: $presenter.someSubviewEntity.binding,
    config: presenter.someSubviewEntity.config,
    onAction: presenter.handleSomeSubviewAction
)
```

---

## Model Rules

```swift
struct SomeModel: Identifiable, Codable, Hashable {
    let id: String
    let someField: String
    let dateCreated: Date

    // snake_case CodingKeys
    enum CodingKeys: String, CodingKey {
        case id
        case someField = "some_field"
        case dateCreated = "date_created"
    }

    // Factory method
    static func new(someField: String) -> Self {
        SomeModel(
            id: UUID().uuidString,
            someField: someField,
            dateCreated: .now
        )
    }

    // Mock data
    static var mock: Self { mocks[0] }
    static var mocks: [Self] {
        [
            SomeModel(id: "mock_1", someField: "Test 1", dateCreated: .now),
            SomeModel(id: "mock_2", someField: "Test 2", dateCreated: .now),
        ]
    }
}
```

**Rules:**
- `CodingKeys` with snake_case mapping
- `static var mock` and `static var mocks` in every model
- Factory method: `static func new(...)` pattern

---

## Service Layer Rules

Each service domain follows this structure:

```
Core/{Domain}/
├── {Domain}Manager.swift           # @Observable class, public API
├── Models/
│   └── {Domain}Model.swift
└── Service/
    ├── {Domain}ServiceProtocol.swift   # Protocol (Sendable)
    ├── Mock{Domain}Service.swift       # Mock implementation
    └── {X}{Domain}Service.swift        # Production (e.g., FirebaseAuthService)
```

### Manager Pattern

```swift
@Observable
class SomeManager {
    private let service: SomeServiceProtocol

    init(service: SomeServiceProtocol) {
        self.service = service
    }

    func doSomething() async throws -> SomeModel {
        try await service.doSomething()
    }
}
```

### Service Protocol

```swift
protocol SomeServiceProtocol: Sendable {
    func doSomething() async throws -> SomeModel
}
```

### Mock Service

```swift
struct MockSomeService: SomeServiceProtocol {
    func doSomething() async throws -> SomeModel {
        .mock
    }
}
```

### Wiring: Manager → CoreInteractor → Module

1. Manager is created in `Dependencies.swift` based on BuildConfiguration
2. Registered in DependencyContainer
3. CoreInteractor resolves from container
4. CoreInteractor exposes methods
5. Module's Interactor protocol picks what it needs
6. `extension CoreInteractor: {Module}Interactor { }` confirms conformance

---

## Preview Rules

Every Screen must have at least 1 `#Preview` block:

```swift
#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    return RouterView { router in
        builder.someScreen(router: router)
    }
}
```

Multiple previews for different states:
- `#Preview("Has data")` — Normal data
- `#Preview("No data")` — Empty state
- `#Preview("Loading")` — Slow loading mock
- `#Preview("Error")` — Error state

---

## Important Patterns Summary

1. **@Observable, NOT @ObservableObject**
2. **@State var presenter, NOT @StateObject**
3. **struct Core types** — CoreInteractor, CoreRouter, CoreBuilder are structs
4. **Entity → Presenter** — Entity is passed to Presenter, not View
5. **Protocol conformance via extension** — `extension CoreInteractor: {Module}Interactor { }`
6. **SwiftfulRouting** — `RouterView`, `Router`, `.showScreen(.push/.sheet/.fullScreenCover)`
7. **Action enum > closures** — Single `onAction: (Action) -> Void`
8. **Subview = zero business logic** — Logic stays in Presenter
9. **Mock-first** — Every service has a Mock version
10. **Screen suffix** — `{Module}Screen`, not `{Module}View`
