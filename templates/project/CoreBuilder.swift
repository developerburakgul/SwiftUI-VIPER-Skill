//
//  CoreBuilder.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import SwiftfulRouting

@MainActor
struct CoreBuilder {
    let interactor: CoreInteractor

    func appView() -> some View {
        RouterView(id: "splash", addNavigationStack: false, addModuleSupport: true) { router in
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

    func userSetupScreen(router: Router, entity: UserSetupEntity = UserSetupEntity()) -> some View {
        UserSetupScreen(
            presenter: UserSetupPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self),
                entity: entity
            )
        )
    }

    func introScreen(router: Router, entity: IntroEntity = IntroEntity()) -> some View {
        IntroScreen(
            presenter: IntroPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self),
                entity: entity
            )
        )
    }

    func tabbarScreen(router: Router, entity: TabbarEntity = TabbarEntity()) -> some View {
        TabbarScreen(
            presenter: TabbarPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self),
                entity: entity,
                builder: self
            )
        )
    }

    func homeScreen(router: Router, entity: HomeEntity = HomeEntity()) -> some View {
        HomeScreen(
            presenter: HomePresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self),
                entity: entity
            )
        )
    }

    func favoritesScreen(router: Router, entity: FavoritesEntity = FavoritesEntity()) -> some View {
        FavoritesScreen(
            presenter: FavoritesPresenter(
                interactor: interactor,
                router: CoreRouter(router: router, builder: self),
                entity: entity
            )
        )
    }

    func settingsScreen(router: Router, entity: SettingsEntity = SettingsEntity()) -> some View {
        SettingsScreen(
            presenter: SettingsPresenter(
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
