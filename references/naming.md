# Naming Conventions

| Type | Convention | Example |
|------|-----------|---------|
| Module Screen | `{Module}Screen` | `ExploreScreen`, `ChatScreen` |
| Module Presenter | `{Module}Presenter` | `ExplorePresenter`, `ChatPresenter` |
| Module Interactor Protocol | `{Module}Interactor` | `ExploreInteractor` |
| Module Router Protocol | `{Module}Router` | `ExploreRouter` |
| Module Entity | `{Module}Entity` | `ChatEntity`, `SettingsEntity` |
| CoreBuilder factory method | `{module}Screen(router:)` | `exploreScreen(router:)` |
| CoreBuilder factory with entity | `{module}Screen(router:entity:)` | `chatScreen(router:entity:)` |
| CoreRouter navigation | `show{Module}Screen(entity:)` | `showChatScreen(entity:)` |
| Service Manager | `{Domain}Manager` | `AuthManager`, `ChatManager` |
| Service Protocol | `{Domain}ServiceProtocol` | `AuthServiceProtocol` |
| Mock Service | `Mock{Domain}Service` | `MockAuthService` |
| Production Service | `{Provider}{Domain}Service` | `FirebaseAuthService` |
| Model | `{Domain}Model` | `ChatModel`, `AvatarModel` |
| Scoped Subview | `extension {Screen} { struct {Subview} }` | `extension ChatScreen { struct MessageInput }` |
| Scoped Subview Entity | `{Screen}.{Subview}Entity` | `ChatScreen.MessageInputEntity` |
| Scoped Binding | `{Screen}.{Subview}Entity.Binding` | nested struct |
| Scoped Config | `{Screen}.{Subview}Entity.Config` | nested struct |
| Common Subview | `{SubviewName}` (standalone) | `SharedInputView` |
| Common Entity | `{SubviewName}Entity` (standalone) | `SharedInputViewEntity` |
| Component View | `{Purpose}View` | `HeroCellView`, `ChatBubbleView` |
| ViewModifier | `{Purpose}ViewModifier` | `OnFirstAppearViewModifier` |
| App Design | `{AppName}Design` | `FinlogueDesign` |

## Action Naming

- Presenter actions: `func onXxxPressed()`, `func didXxx()`
- Subview Action enum: `case didTapXxx`, `case didChangeXxx`
- CoreRouter: `func show{Module}Screen(entity:)`
- CoreRouter dismiss: `func dismissScreen()`, `func dismissModal()`

## File Naming

- Screen: `{Module}Screen.swift`
- Presenter: `{Module}Presenter.swift`
- Interactor: `{Module}Interactor.swift`
- Router: `{Module}Router.swift`
- Entity: `{Module}Entity.swift`
- Subview: `{SubviewName}.swift`
- Subview Entity: `{SubviewName}Entity.swift`
- Subview Binding: `{SubviewName}Binding.swift`
- Subview Config: `{SubviewName}Config.swift`
