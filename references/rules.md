# Code Generation Rules

> Tüm kod üretim workflow'larında geçerli olan kurallar.

## Architecture

1. **ObservableObject, NOT @Observable** — Combine's ObservableObject for iOS 16+ support
2. **@StateObject var presenter, NOT @State**
3. **struct CoreInteractor / CoreRouter / CoreBuilder** — Value types, not classes
4. **Entity → Presenter** — Entity is passed to Presenter, never directly to View
5. **Protocol conformance via extension** — `extension CoreInteractor: {Module}Interactor { }`

## Navigation

6. **SwiftfulRouting only** — `RouterView`, `Router`, `.showScreen(.push/.sheet/.fullScreenCover)`
7. **No NavigationStack / NavigationView** — All navigation managed by SwiftfulRouting

## Presenter

8. **@MainActor** on all Presenters
9. **@Published private(set) var** for all published state properties
10. **Computed properties** in separate `extension`

## Protocols

11. **@MainActor** on all Interactor and Router protocols

## Subviews

12. **View, @MainActor Equatable** with manual `==` implementation
13. **Action enum** — Single `onAction: (Action) -> Void` closure, no multiple closures
14. **Config = `let`** (read-only), **Binding = `@Binding`** (two-way)

## Models

15. **Identifiable, Codable, Hashable** with snake_case `CodingKeys`
16. **static var mock / mocks** in every model

## Services & DI

17. **Service protocols conform to Sendable**
18. **Mock-first development** — Every service has a Mock version
19. **BurakKit modules** — `import DependencyContainer` for DI, `import DynamicColor` for theme
20. **3 Build Configurations** — Mock (`MOCK` flag), Dev (`DEV`), Prod (`PROD`)

## Naming

21. **Screen suffix** — `{Module}Screen`, not `{Module}View`
22. **Flat file structure** — No `Entity/` subfolder in modules or subviews

## Previews

23. **Every Screen** needs at least one `#Preview` using `DevPreview.shared.container`

## Prohibited

24. **No print()** — Use `os_log`
25. **No force unwrap (!)** — Never use `!`
