//
//  CoreRouter.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import SwiftfulRouting
typealias Router = SwiftfulRouting.AnyRouter
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

    func showHomeScreen(entity: HomeEntity = HomeEntity()) {
        router.showScreen(.push) { router in
            builder.homeScreen(router: router, entity: entity)
        }
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
        router.showAlert(.alert, title: "Error", subtitle: error.localizedDescription)
    }

    func showSimpleAlert(title: String, subtitle: String?) {
        router.showAlert(.alert, title: title, subtitle: subtitle)
    }

    func dismissAlert() {
        router.dismissAlert()
    }
}
