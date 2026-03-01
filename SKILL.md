---
name: swiftui-viper
description: |
  SwiftUI + VIPER architecture skill for creating projects, modules, subviews, and services.
  Use this skill whenever the user asks to:
  - Create a new iOS/SwiftUI project from scratch
  - Add a new screen/module/feature to an existing project
  - Add a scoped or common subview to a module
  - Add a new service domain (Manager + Protocol + Mock)
  - Scaffold project structure with XcodeGen
  - Work with the modified VIPER pattern (CoreBuilder, CoreInteractor, CoreRouter)
  Trigger on: "new project", "new module", "new screen", "add subview", "add service",
  "create feature", "scaffold", "VIPER", "CoreBuilder", "CoreRouter", "CoreInteractor",
  or any SwiftUI architecture/module creation task.
---

# SwiftUI VIPER Skill

## ⚠️ CRITICAL: Read This First

This is a **modified VIPER** architecture. Do NOT use classic VIPER patterns.
Before generating ANY code, identify the workflow and read the relevant template + reference files.

> Architecture details: `references/architecture.md` | Code rules: `references/rules.md`

## Workflow Decision Tree

### 1. "Create new project" / "Yeni proje oluştur"

**Read:** `references/rules.md`, `references/architecture.md`, `references/swiftful-routing.md`, `references/dynamic-color.md`, `templates/project/*`

**Steps:**
1. Read the files listed above
2. Ask user for: App name, bundle ID, deployment target, initial modules
3. **Create all folders first** (XcodeGen needs these on disk):
   ```bash
   mkdir -p {AppName}/{AppName}/Root/CoreRIB
   mkdir -p {AppName}/{AppName}/Modules
   mkdir -p {AppName}/{AppName}/Core
   mkdir -p {AppName}/{AppName}/Components
   mkdir -p {AppName}/{AppName}/Design
   mkdir -p {AppName}/{AppName}/Extensions
   mkdir -p {AppName}/{AppName}/Utilities
   ```
4. Generate files from templates into the correct paths:
   ```
   {AppName}/
   ├── {AppName}/
   │   ├── Root/
   │   │   ├── {AppName}App.swift          ← templates/project/__AppName__App.swift
   │   │   ├── AppDelegate.swift            ← templates/project/AppDelegate.swift
   │   │   ├── CoreRIB/
   │   │   │   ├── CoreBuilder.swift        ← templates/project/CoreBuilder.swift
   │   │   │   ├── CoreInteractor.swift     ← templates/project/CoreInteractor.swift
   │   │   │   └── CoreRouter.swift         ← templates/project/CoreRouter.swift
   │   │   └── Dependencies.swift           ← templates/project/Dependencies.swift
   │   ├── Modules/
   │   │   ├── Splash/                        ← templates/project/Modules/Splash/* (her açılışta gösterilir)
   │   │   │   ├── SplashScreen.swift
   │   │   │   ├── SplashPresenter.swift
   │   │   │   ├── SplashInteractor.swift
   │   │   │   ├── SplashRouter.swift
   │   │   │   └── SplashEntity.swift
   │   │   ├── Intro/                          ← templates/project/Modules/Intro/* (ilk açılış tanıtım)
   │   │   │   ├── IntroScreen.swift
   │   │   │   ├── IntroPresenter.swift
   │   │   │   ├── IntroInteractor.swift
   │   │   │   ├── IntroRouter.swift
   │   │   │   ├── IntroEntity.swift
   │   │   │   └── Subviews/
   │   │   │       └── IntroPage/
   │   │   │           ├── IntroPage.swift
   │   │   │           ├── IntroPageEntity.swift
   │   │   │           ├── IntroPageBinding.swift
   │   │   │           └── IntroPageConfig.swift
   │   │   ├── UserSetup/                       ← templates/project/Modules/UserSetup/* (kullanıcı kurulum)
   │   │   │   ├── UserSetupScreen.swift
   │   │   │   ├── UserSetupPresenter.swift
   │   │   │   ├── UserSetupInteractor.swift
   │   │   │   ├── UserSetupRouter.swift
   │   │   │   ├── UserSetupEntity.swift
   │   │   │   └── Subviews/
   │   │   │       ├── StepOne/
   │   │   │       │   ├── StepOne.swift
   │   │   │       │   ├── StepOneEntity.swift
   │   │   │       │   ├── StepOneBinding.swift
   │   │   │       │   └── StepOneConfig.swift
   │   │   │       ├── StepTwo/
   │   │   │       │   ├── StepTwo.swift
   │   │   │       │   ├── StepTwoEntity.swift
   │   │   │       │   ├── StepTwoBinding.swift
   │   │   │       │   └── StepTwoConfig.swift
   │   │   │       └── StepThree/
   │   │   │           ├── StepThree.swift
   │   │   │           ├── StepThreeEntity.swift
   │   │   │           ├── StepThreeBinding.swift
   │   │   │           └── StepThreeConfig.swift
   │   │   ├── Tabbar/                         ← templates/project/Modules/Tabbar/* (TabView container)
   │   │   │   ├── TabbarScreen.swift
   │   │   │   ├── TabbarPresenter.swift
   │   │   │   ├── TabbarInteractor.swift
   │   │   │   ├── TabbarRouter.swift
   │   │   │   └── TabbarEntity.swift
   │   │   ├── Home/                             ← templates/project/Modules/Home/* (tab modülü)
   │   │   │   ├── HomeScreen.swift
   │   │   │   ├── HomePresenter.swift
   │   │   │   ├── HomeInteractor.swift
   │   │   │   ├── HomeRouter.swift
   │   │   │   └── HomeEntity.swift
   │   │   ├── Favorites/                     ← templates/project/Modules/Favorites/* (tab modülü)
   │   │   │   ├── FavoritesScreen.swift
   │   │   │   ├── FavoritesPresenter.swift
   │   │   │   ├── FavoritesInteractor.swift
   │   │   │   ├── FavoritesRouter.swift
   │   │   │   └── FavoritesEntity.swift
   │   │   └── Settings/                      ← templates/project/Modules/Settings/* (tab modülü)
   │   │       ├── SettingsScreen.swift
   │   │       ├── SettingsPresenter.swift
   │   │       ├── SettingsInteractor.swift
   │   │       ├── SettingsRouter.swift
   │   │       └── SettingsEntity.swift
   │   ├── Core/
   │   │   └── User/                          ← templates/project/Core/User/* (default servis)
   │   │       ├── UserManager.swift
   │   │       └── Service/
   │   │           ├── UserServiceProtocol.swift
   │   │           ├── UserService.swift
   │   │           └── MockUserService.swift
   │   ├── Assets.xcassets/              ← templates/project/Assets.xcassets (AccentColor, AppIcon)
   │   ├── Info.plist
   │   ├── Components/
   │   │   ├── Views/
   │   │   ├── ViewModifiers/
   │   │   ├── Modals/
   │   │   ├── Buttons/
   │   │   └── Images/
   │   ├── Design/
   │   │   └── {AppName}Design.swift        ← generate from references/dynamic-color.md pattern
   │   ├── Extensions/                       (empty)
   │   └── Utilities/                        (empty)
   ├── project.yml                           ← templates/project/project.yml
   └── .gitignore                            ← templates/project/.gitignore.template
   ```
5. Replace all `__AppName__`, `__BundleIdPrefix__`, `__DeploymentTarget__`, `__GitHubUser__`, `__Username__`, `__Date__` placeholders
6. Generate `project.yml` from template, replacing placeholders
7. Run: `cd {AppName} && xcodegen generate`
8. Optionally run: `open {AppName}.xcodeproj`

**Template files to read:** `templates/project/*`

---

### 2. "Create new module/screen" / "Yeni modül/ekran oluştur"

**Read:** `references/rules.md`, `references/naming.md`, `templates/module/*`

**Steps:**
1. Read the files listed above
2. Ask user for: Module name (e.g., "Settings", "Receipt")
3. Create folder: `Modules/{ModuleName}/`
4. Generate 5 files from templates, replacing `__ModuleName__` and `__moduleName__` (camelCase) placeholders:
   - `{ModuleName}Screen.swift`
   - `{ModuleName}Presenter.swift`
   - `{ModuleName}Interactor.swift`
   - `{ModuleName}Router.swift`
   - `{ModuleName}Entity.swift`
5. Create empty `Subviews/` folder
6. **Update CoreBuilder.swift** — Add factory method: `builder.__moduleName__Screen(router:entity:)`
7. **Update CoreRouter.swift** — Add navigation method (if needed). See `references/swiftful-routing.md` for showScreen/showModal/showAlert API details

**Template files to read:** `templates/module/*`

---

### 3. "Add subview to module" / "Subview ekle"

**Two types — ask which one:**

#### 3a. Scoped Subview (screen-specific)

**Read:** `references/rules.md`, `references/patterns.md`, `templates/subview/scoped/*`

1. Read the files listed above
2. Ask user for: Scope name (parent screen), Subview name
3. Create folder: `Modules/{ScopeName}/Subviews/{SubviewName}/`
4. Generate 4 files, replacing `__ScopeName__` and `__ViewName__`:
   - `{SubviewName}.swift`
   - `{SubviewName}Entity.swift`
   - `{SubviewName}Binding.swift`
   - `{SubviewName}Config.swift`
5. **Update Presenter** — Aşağıdaki 3 eklemeyi yap:
   a. `@Published var {subviewName}Entity: {ScopeName}.{SubviewName}Entity` property ekle (Published Properties bölümüne)
   b. `init` içinde entity'yi başlat: `self.{subviewName} = .init(binding: .init(...), config: .init(...))`
   c. Action handler metodu ekle (Actions bölümüne):
      ```swift
      func on{SubviewName}Action(_ action: {ScopeName}.{SubviewName}.Action) {
          switch action {
          case .didTapXxx:
              break
          }
      }
      ```

#### 3b. Common Subview (reusable)

**Read:** `references/rules.md`, `references/patterns.md`, `templates/subview/common/*`

1. Read the files listed above
2. Ask user for: View name
3. Create folder: `Components/Views/{ViewName}/`
4. Generate 4 files, replacing `__ViewName__`:
   - Same structure but standalone (no extension)

**Template files to read:** `templates/subview/scoped/*` or `templates/subview/common/*`

---

### 4. "Add service domain" / "Yeni servis ekle"

**Read:** `references/rules.md`, `references/patterns.md`, `references/naming.md`, `templates/service/*`

**Steps:**
1. Read the files listed above
2. Ask user for: Domain name (e.g., "Auth", "Payment", "Receipt")
3. Create folder structure:
   ```
   Core/{Domain}/
   ├── {Domain}Manager.swift
   ├── Models/
   └── Service/
       ├── {Domain}ServiceProtocol.swift
       └── Mock{Domain}Service.swift
   ```
   > Production service (e.g., `Firebase{Domain}Service.swift`) is NOT templated — create manually when needed.
4. **Update CoreInteractor.swift** — Add manager property + methods
5. **Update Dependencies.swift** — Register manager in container
6. **Update DevPreview** — Add mock manager

**Template files to read:** `templates/service/*`

---

### 5. General code questions / Architecture guidance

Read `references/architecture.md` and `references/patterns.md` for detailed rules.
For navigation questions, read `references/swiftful-routing.md` for full SwiftfulRouting API reference (showScreen, showModal, showAlert, showTransition, showModule, dismiss patterns).

---

### 6. DynamicColor / Theme colors

Read `references/dynamic-color.md` for `@DynamicColor`, `ThemeStore`, `Color.init(hex:)` usage and `{AppName}Design.swift` pattern.

---

## ⚠️ Script Status

> **`create_module.sh` and `create_subview.sh` reference a deleted `xctemplate/` directory and will fail.**
> Claude Code should generate files directly from `templates/module/` and `templates/subview/` instead of running these scripts.
> `create_project.sh` and `create_service.sh` work correctly.

> SPM Dependencies: `references/architecture.md`
