# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

This is a **Claude Code skill repository** — not a buildable iOS project. It provides templates, scripts, and reference docs that Claude uses to scaffold SwiftUI projects following a modified VIPER architecture. It gets installed into `.claude/skills/` of target projects.

## Architecture: Modified VIPER

This is NOT classic VIPER. The key difference is three shared Core structs instead of per-module VIPER components:

```
View ←→ Presenter ←→ Interactor(protocol) → CoreInteractor → Manager → Service → Model
                  ←→ Router(protocol)      → CoreRouter     → Builder
```

- **CoreBuilder** (struct) — Single factory that creates ALL screens. Each module gets a `{module}Screen(router:entity:)` method.
- **CoreInteractor** (struct) — Single struct resolving ALL managers from `DependencyContainer`. Modules define protocol slices; CoreInteractor conforms via `extension CoreInteractor: {Module}Interactor { }`.
- **CoreRouter** (struct) — Single struct holding `Router` (SwiftfulRouting) + `CoreBuilder`. Modules define protocol slices; CoreRouter conforms via `extension CoreRouter: {Module}Router { }`.
- **Presenter** (`ObservableObject class`, `@MainActor`) — Per-module. Receives interactor + router + entity.
- **Entity** (struct) — Per-module parameters passed between modules via CoreBuilder.
- **Screen** (SwiftUI View) — `@StateObject var presenter`, zero business logic, suffix is `Screen` not `View`.

## Repository Structure

```
├── SKILL.md                    # Skill trigger config and workflow decision tree
├── references/
│   ├── architecture.md         # Full VIPER pattern details with code examples
│   ├── naming.md               # All naming conventions (files, types, methods)
│   ├── patterns.md             # Subview, Model, Service layer patterns
│   ├── dynamic-color.md        # BurakKit DynamicColor/theme system
│   └── swiftful-routing.md     # SwiftfulRouting navigation API and patterns
├── templates/
│   ├── project/                # New project boilerplate (App.swift, CoreRIB, Dependencies, project.yml)
│   ├── module/                 # VIPER module templates (Screen, Presenter, Interactor, Router, Entity)
│   ├── service/                # Service domain templates (Manager, Protocol, Mock)
│   └── subview/
│       ├── scoped/             # Screen-specific subview templates
│       └── common/             # Reusable subview templates
└── scripts/
    ├── create_project.sh       # Scaffold full project
    ├── create_module.sh        # Add VIPER module to existing project
    ├── create_subview.sh       # Add scoped or common subview
    └── create_service.sh       # Add service domain (Manager + Protocol + Mock)
```

## Scripts

```bash
# Yeni proje oluştur
./scripts/create_project.sh <AppName> <BundleIdPrefix> <DeploymentTarget> [GitHubUser]

# Mevcut projeye modül ekle
./scripts/create_module.sh <ModuleName> [ProjectSourceDir]

# Subview ekle (scoped veya common)
./scripts/create_subview.sh <scoped|common> <ViewName> [ScopeName] [ProjectSourceDir]

# Servis domain'i ekle
./scripts/create_service.sh <DomainName> [ProjectSourceDir]
```

All project generation requires XcodeGen (`brew install xcodegen`). After generating files, run `cd {AppName} && xcodegen generate`.

## Workflow: How the Skill Gets Used

The `SKILL.md` frontmatter defines trigger keywords. When Claude detects a matching request:

1. Read the relevant **templates** and **references** for the workflow (project/module/subview/service)
2. Ask the user for required parameters (app name, module name, etc.)
3. Generate files by replacing placeholders (`__AppName__`, `__ModuleName__`, etc.)
4. After module/service creation, remind to update CoreBuilder, CoreRouter, CoreInteractor, and Dependencies as needed

## SPM Dependencies (in Generated Projects)

| Package | Modules | Purpose |
|---------|---------|---------|
| **BurakKit** (0.1.0) | `DependencyContainer` | DI container for resolving managers |
| | `DynamicColor` | Theme-aware colors (`@DynamicColor`, `ThemeStore`, `Color(hex:)`) |
| **SwiftfulRouting** (6.0.0+) | — | Navigation (`RouterView`, `AnyRouter`, `.showScreen(.push/.sheet/.fullScreenCover)`) |

## DynamicColor Quick Reference

- `@DynamicColor var primary: Color` — Theme-aware color property in `{AppName}Design`
- `ThemeStore` — Observable store for current theme (persisted in UserDefaults)
- `{AppName}Design.swift` — Single file defining all app colors using `@DynamicColor`
- See `references/dynamic-color.md` for full pattern

## Navigation Quick Reference

- `showScreen(.push/.sheet/.fullScreenCover)` — Navigate to a new screen
- `showModal(transition:)` — Present a modal with custom transition
- `showModule(module:)` — Present a SwiftfulRouting module
- `showAlert(.alert/.confirmationDialog)` — Show system alerts
- `dismiss()` / `dismissModal()` / `dismissScreen()` — Dismiss navigation

## Critical Rules for Generated Code

- `ObservableObject` not `@Observable`; `@StateObject var presenter` not `@State`
- CoreInteractor, CoreRouter, CoreBuilder are **structs**, not classes
- Entity goes to Presenter, never directly to View
- Protocol conformance always via extension: `extension CoreInteractor: {Module}Interactor { }`
- Subview actions use `enum Action` with single `onAction` closure — no multiple closures
- Every Screen needs at least one `#Preview` using `DevPreview.shared.container`
- Models conform to `Identifiable, Codable, Hashable` with snake_case `CodingKeys` and `static var mock`/`mocks`
- Service protocols conform to `Sendable`
- 3 build configurations: Mock (`MOCK` flag), Dev (`DEV`), Prod (`PROD`)
- No `NavigationStack` — all navigation is handled by SwiftfulRouting (`RouterView`, `Router`, `.showScreen`)
- No `print()` — use `os_log`
- No force unwrap (`!`)
- Presenter: `@MainActor`, `@Published private(set) var` for state, computed properties in separate extension
- Protocols: All Interactor and Router protocols must be `@MainActor`
- Subviews: `View, @MainActor Equatable` with manual `==` implementation
- Config = `let` (read-only), Binding = `@Binding` (two-way)
- Flat file structure — no `Entity/` subfolder in modules or subviews

## Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Screen | `{Module}Screen` | `ExploreScreen` |
| Presenter | `{Module}Presenter` | `ExplorePresenter` |
| Interactor Protocol | `{Module}Interactor` | `ExploreInteractor` |
| Router Protocol | `{Module}Router` | `ExploreRouter` |
| Entity | `{Module}Entity` | `ChatEntity` |
| CoreBuilder factory | `{module}Screen(router:entity:)` | `exploreScreen(router:entity:)` |
| CoreRouter nav | `show{Module}Screen(entity:)` | `showChatScreen(entity:)` |
| Manager | `{Domain}Manager` | `AuthManager` |
| Service Protocol | `{Domain}ServiceProtocol` | `AuthServiceProtocol` |
| Mock Service | `Mock{Domain}Service` | `MockAuthService` |
| Prod Service | `{Provider}{Domain}Service` | `FirebaseAuthService` |
| Scoped Subview | `extension {Screen} { struct {Name} }` | `extension ChatScreen { struct MessageInput }` |
| Presenter actions | `onXxxPressed()` / `didXxx()` | `onItemPressed()` |
| Subview actions | `case didTapXxx` / `case didChangeXxx` | `case didTapSubmit` |
