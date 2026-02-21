//
//  Dependencies.swift
//

import SwiftUI
import DependencyContainer

@MainActor
struct Dependencies {
    let container: DependencyContainer

    init(config: BuildConfiguration) {
        let container = DependencyContainer()

        switch config {
        case .mock:
            break
            // TODO: Initialize mock services
            // let authManager = AuthManager(service: MockAuthService())
            // container.register(AuthManager.self, service: authManager)
        case .dev:
            break
            // TODO: Initialize dev services
        case .prod:
            break
            // TODO: Initialize prod services
        }

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
        // TODO: Register mock managers
        return container
    }

    init() {
        // TODO: Initialize mock managers
    }
}
