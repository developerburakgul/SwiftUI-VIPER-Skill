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

## Quick Reference: Architecture

```
View ←→ Presenter ←→ Interactor(protocol) → CoreInteractor → Manager → Service → Model
                  ←→ Router(protocol)      → CoreRouter     → Builder
```

- **CoreInteractor** → Single shared struct, resolves managers from DependencyContainer
- **CoreRouter** → Single shared struct, holds Router + CoreBuilder
- **CoreBuilder** → Single shared struct, factory methods for all screens
- **Presenter** → Per-module @Observable class, receives interactor + router + entity
- **Entity** → Per-module struct, parameters passed from another module via CoreBuilder

## Workflow Decision Tree

### 1. "Create new project" / "Yeni proje oluştur"

**Steps:**
1. Read `references/architecture.md` for full pattern details
2. Read ALL files in `templates/project/` for boilerplate code
3. Ask user for: App name, bundle ID, deployment target, initial modules
4. Generate project structure:
   ```
   {AppName}/
   ├── {AppName}/
   │   ├── Root/
   │   │   ├── {AppName}App.swift
   │   │   ├── AppDelegate.swift
   │   │   ├── CoreRIB/
   │   │   │   ├── CoreBuilder.swift
   │   │   │   ├── CoreInteractor.swift
   │   │   │   └── CoreRouter.swift
   │   │   └── Dependencies.swift
   │   ├── Modules/
   │   ├── Core/
   │   ├── Components/
   │   ├── Design/
   │   │   └── {AppName}Design.swift
   │   ├── Extensions/
   │   └── Utilities/
   ├── project.yml
   └── .gitignore
   ```
5. Generate `project.yml` from template, replacing placeholders
6. Run: `cd {AppName} && xcodegen generate`
7. Optionally run: `open {AppName}.xcodeproj`

**Template files to read:** `templates/project/*`

---

### 2. "Create new module/screen" / "Yeni modül/ekran oluştur"

**Steps:**
1. Read `templates/module/` for all 5 template files
2. Read `references/naming.md` for naming conventions
3. Ask user for: Module name (e.g., "Settings", "Receipt")
4. Create folder: `Modules/{ModuleName}/`
5. Generate 5 files from templates, replacing `__ModuleName__` placeholder:
   - `{ModuleName}Screen.swift`
   - `{ModuleName}Presenter.swift`
   - `{ModuleName}Interactor.swift`
   - `{ModuleName}Router.swift`
   - `Entity/{ModuleName}Entity.swift`
6. Create empty `Subviews/` folder
7. **Update CoreBuilder.swift** — Add factory method
8. **Update CoreRouter.swift** — Add navigation method (if needed)

**Template files to read:** `templates/module/*`

---

### 3. "Add subview to module" / "Subview ekle"

**Two types — ask which one:**

#### 3a. Scoped Subview (screen-specific)
1. Read `templates/subview/scoped/` for all 4 template files
2. Ask user for: Scope name (parent screen), Subview name
3. Create folder: `Modules/{ScopeName}/Subviews/{SubviewName}/`
4. Generate 4 files, replacing `__ScopeName__` and `__ViewName__`:
   - `{SubviewName}.swift`
   - `Entity/{SubviewName}Entity.swift`
   - `Entity/{SubviewName}Binding.swift`
   - `Entity/{SubviewName}Config.swift`
5. **Update Presenter** — Add entity property and action handler

#### 3b. Common Subview (reusable)
1. Read `templates/subview/common/` for all 4 template files
2. Ask user for: View name
3. Create folder: `Components/Views/{ViewName}/`
4. Generate 4 files, replacing `__ViewName__`:
   - Same structure but standalone (no extension)

**Template files to read:** `templates/subview/scoped/*` or `templates/subview/common/*`

---

### 4. "Add service domain" / "Yeni servis ekle"

**Steps:**
1. Read `templates/service/` for all template files
2. Read `references/patterns.md` for service layer rules
3. Ask user for: Domain name (e.g., "Auth", "Payment", "Receipt")
4. Create folder structure:
   ```
   Core/{Domain}/
   ├── {Domain}Manager.swift
   ├── Models/
   └── Service/
       ├── {Domain}ServiceProtocol.swift
       ├── Mock{Domain}Service.swift
       └── {X}{Domain}Service.swift
   ```
5. **Update CoreInteractor.swift** — Add manager property + methods
6. **Update Dependencies.swift** — Register manager in container
7. **Update DevPreview** — Add mock manager

**Template files to read:** `templates/service/*`

---

### 5. General code questions / Architecture guidance

Read `references/architecture.md` and `references/patterns.md` for detailed rules.

---

## Key Rules (Always Apply)

1. **@Observable, NOT @ObservableObject** — Use Observation framework
2. **@State var presenter, NOT @StateObject**
3. **struct CoreInteractor/CoreRouter/CoreBuilder** — Value types
4. **Entity goes to Presenter**, not View
5. **Protocol conformance via extension** — `extension CoreInteractor: {Module}Interactor { }`
6. **SwiftfulRouting** — `RouterView`, `Router`, `.showScreen(.push/.sheet/.fullScreenCover)`
7. **DependencyContainer from BurakKit** — `import BurakKit`
8. **Mock-first development** — Every service has a Mock version
9. **Screen suffix** — Views are `{Module}Screen`, not `{Module}View`
10. **3 Build Configurations** — Mock, Dev, Prod

## SPM Dependencies

### Base (always included)
| Package | Usage |
|---------|-------|
| BurakKit | DependencyContainer, shared utilities |
| SwiftfulRouting | Navigation (RouterView, Router) |

### Optional (add based on project needs)
| Package | Usage |
|---------|-------|
| DynamicTheme | Theme management (light/dark/system) |
| RevenueCat / RevenueCatUI | In-App Purchase |
| SDWebImageSwiftUI | Remote image loading |
| SwiftfulUtilities | Utility helpers |
| IdentifiableByString | StringIdentifiable protocol |
