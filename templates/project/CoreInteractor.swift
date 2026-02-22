//
//  CoreInteractor.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import DependencyContainer

@MainActor
struct CoreInteractor {

    let userManager: UserManager

    init(container: DependencyContainer) {
        self.userManager = container.resolve(UserManager.self)!
        // TODO: Resolve managers as needed
        // self.authManager = container.resolve(AuthManager.self)!
    }

    // MARK: - User

    var isOnboardingComplete: Bool {
        userManager.isOnboardingComplete
    }

    func markOnboardingComplete() {
        userManager.markOnboardingComplete()
    }

    // MARK: - Splash

    func performStartupTasks() async {
        // Splash ekranının minimum görünme süresi
        try? await Task.sleep(for: .seconds(2))
        // TODO: Uygulama açılışında yapılacak işlemleri buraya ekleyin
        // Örnek: API config fetch, remote config, authentication check vb.
    }

    // MARK: - Add manager methods here
    // Each module defines a protocol for what it needs.
    // CoreInteractor conforms via extension in the module's Interactor file.
}
