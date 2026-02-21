//
//  CoreBuilder.swift
//

import SwiftUI
import SwiftfulRouting

@MainActor
struct CoreBuilder {
    let interactor: CoreInteractor

    func appView() -> some View {
        // TODO: Replace with your root view
        RouterView { router in
            Text("Welcome to __AppName__")
        }
    }

    // MARK: - Module Factories

    // Example:
    // func someScreen(router: Router, entity: SomeEntity = SomeEntity()) -> some View {
    //     SomeScreen(
    //         presenter: SomePresenter(
    //             interactor: interactor,
    //             router: CoreRouter(router: router, builder: self),
    //             entity: entity
    //         )
    //     )
    // }
}
