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
