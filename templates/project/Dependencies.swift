//
//  Dependencies.swift
//

import SwiftUI
import DependencyContainer

@MainActor
struct Dependencies {
    let container: DependencyContainer
    let appState: AppState

    init(config: BuildConfiguration) {
        switch config {
        case .mock:
            appState = AppState()
            // TODO: Initialize mock services
            // authManager = AuthManager(service: MockAuthService())
        case .dev:
            appState = AppState()
            // TODO: Initialize dev services
        case .prod:
            appState = AppState()
            // TODO: Initialize prod services
        }

        let container = DependencyContainer()
        container.register(AppState.self, service: appState)
        // TODO: Register other managers
        // container.register(AuthManager.self, service: authManager)
        self.container = container
    }
}

// MARK: - Preview Helpers

extension View {
    func previewEnvironment() -> some View {
        self
    }
}

@MainActor
class DevPreview {
    static let shared = DevPreview()

    var container: DependencyContainer {
        let container = DependencyContainer()
        container.register(AppState.self, service: appState)
        // TODO: Register mock managers
        return container
    }

    let appState: AppState

    init() {
        self.appState = AppState()
        // TODO: Initialize mock managers
    }
}
