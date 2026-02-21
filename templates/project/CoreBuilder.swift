//
//  CoreBuilder.swift
//

import SwiftUI
import SwiftfulRouting

@MainActor
struct CoreBuilder {
    let interactor: CoreInteractor

    func appView() -> some View {
        RouterView { router in
            splashScreen(router: router)
        }
    }

    // MARK: - Module Factories

    func splashScreen(router: Router, entity: SplashEntity = SplashEntity()) -> some View {
        SplashScreen(
            presenter: SplashPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self),
                entity: entity
            )
        )
    }

    func onboardingScreen(router: Router, entity: OnboardingEntity = OnboardingEntity()) -> some View {
        OnboardingScreen(
            presenter: OnboardingPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self),
                entity: entity
            )
        )
    }

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
