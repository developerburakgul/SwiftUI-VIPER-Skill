//
//  CoreRouter.swift
//

import SwiftUI
import SwiftfulRouting

@MainActor
struct CoreRouter {
    let router: Router
    let builder: CoreBuilder

    // MARK: - Segues

    func showOnboardingScreen(entity: OnboardingEntity = OnboardingEntity()) {
        router.showScreen(.push) { router in
            builder.onboardingScreen(router: router, entity: entity)
        }
    }

    func showHomeScreen() {
        // TODO: Home modülünü oluşturduktan sonra buraya ekleyin
        // router.showScreen(.push) { router in
        //     builder.homeScreen(router: router)
        // }
    }

    // Example:
    // func showSomeScreen(entity: SomeEntity) {
    //     router.showScreen(.push) { router in
    //         builder.someScreen(router: router, entity: entity)
    //     }
    // }

    // MARK: - Dismiss

    func dismissScreen() {
        router.dismissScreen()
    }

    func dismissModal() {
        router.dismissModal()
    }

    // MARK: - Alerts

    func showAlert(error: Error) {
        router.showAlert(.alert, title: "Error", subtitle: error.localizedDescription, buttons: nil)
    }

    func showSimpleAlert(title: String, subtitle: String?) {
        router.showAlert(.alert, title: title, subtitle: subtitle, buttons: nil)
    }

    func dismissAlert() {
        router.dismissAlert()
    }
}
