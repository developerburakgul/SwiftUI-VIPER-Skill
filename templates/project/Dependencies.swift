//
//  Dependencies.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import DependencyContainer

@MainActor
struct Dependencies {
    let container: DependencyContainer

    init(config: BuildConfiguration) {
        let container = DependencyContainer()

        // Onboarding — UserDefaults tüm config'lerde aynı şekilde çalışır
        let onboardingManager = OnboardingManager(service: OnboardingService())
        container.register(OnboardingManager.self, service: onboardingManager)

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

    let onboardingManager: OnboardingManager

    var container: DependencyContainer {
        let container = DependencyContainer()
        container.register(OnboardingManager.self, service: onboardingManager)
        // TODO: Register mock managers
        return container
    }

    init() {
        self.onboardingManager = OnboardingManager(service: MockOnboardingService())
        // TODO: Initialize mock managers
    }
}
