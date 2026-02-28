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

    func showUserSetupScreen(_ entity: UserSetupEntity = UserSetupEntity()) {
        router.showModule(.identity, id: "userSetup") { _ in
            RouterView(addNavigationStack: false) { router in
                builder.userSetupScreen(router: router, entity: entity)
            }
        }
    }

    func showIntroScreen(_ entity: IntroEntity = IntroEntity()) {
        router.showModule(.identity, id: "intro") { _ in
            RouterView(addNavigationStack: false) { router in
                builder.introScreen(router: router, entity: entity)
            }
        }
    }

    func showTabbarScreen(_ entity: TabbarEntity = TabbarEntity()) {
        router.showModule(.identity, id: "tabbar") { _ in
            RouterView(addNavigationStack: false) { router in
                builder.tabbarScreen(router: router, entity: entity)
            }
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
