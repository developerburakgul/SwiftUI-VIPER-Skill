# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

This is a **Claude Code skill repository** — not a buildable iOS project. It provides templates, scripts, and reference docs that Claude uses to scaffold SwiftUI projects following a modified VIPER architecture. It gets installed into `.claude/skills/` of target projects.

## Repository Structure

```
├── SKILL.md                    # Skill trigger config and workflow decision tree
├── references/
│   ├── rules.md                # All code generation rules (canonical source)
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

## Workflow: How the Skill Gets Used

The `SKILL.md` frontmatter defines trigger keywords. When Claude detects a matching request:

1. Read the relevant **templates** and **references** for the workflow (each workflow lists its files)
2. Ask the user for required parameters (app name, module name, etc.)
3. Generate files by replacing placeholders (`__AppName__`, `__ModuleName__`, etc.)
4. After module/service creation, remind to update CoreBuilder, CoreRouter, CoreInteractor, and Dependencies as needed

## Quick Pointers

- **Code rules** → `references/rules.md`
- **Architecture & SPM deps** → `references/architecture.md`
- **Naming conventions** → `references/naming.md`
- **Subview / Model / Service patterns** → `references/patterns.md`
- **DynamicColor / Theme** → `references/dynamic-color.md`
- **Navigation API** → `references/swiftful-routing.md`
