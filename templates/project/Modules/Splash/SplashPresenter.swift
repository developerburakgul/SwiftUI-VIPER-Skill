//
//  SplashPresenter.swift
//

import SwiftUI

@Observable
@MainActor
class SplashPresenter {

    // MARK: - Private Properties
    private let interactor: SplashInteractor
    private let router: SplashRouter
    private let entity: SplashEntity

    // MARK: - Published Properties

    // MARK: - Init
    init(
        interactor: SplashInteractor,
        router: SplashRouter,
        entity: SplashEntity
    ) {
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    // MARK: - Actions

    func onAppear() async {
        await interactor.performStartupTasks()

        if interactor.hasCompletedOnboarding {
            router.showHomeScreen()
        } else {
            router.showOnboardingScreen()
        }
    }
}

// MARK: - Computed Properties
extension SplashPresenter {

}
