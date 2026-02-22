//
//  CoreInteractor.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import DependencyContainer

@MainActor
struct CoreInteractor {

    let onboardingManager: OnboardingManager

    init(container: DependencyContainer) {
        self.onboardingManager = container.resolve(OnboardingManager.self)!
        // TODO: Resolve managers as needed
        // self.authManager = container.resolve(AuthManager.self)!
    }

    // MARK: - Onboarding

    var hasCompletedOnboarding: Bool {
        onboardingManager.hasCompleted
    }

    func completeOnboarding() {
        onboardingManager.completeOnboarding()
    }

    // MARK: - Splash

    func performStartupTasks() async {
        // TODO: Uygulama açılışında yapılacak işlemleri buraya ekleyin
        // Örnek: API config fetch, remote config, authentication check vb.
    }

    // MARK: - Add manager methods here
    // Each module defines a protocol for what it needs.
    // CoreInteractor conforms via extension in the module's Interactor file.
}
