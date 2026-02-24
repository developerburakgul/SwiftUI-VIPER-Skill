//
//  SplashPresenter.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

@MainActor
class SplashPresenter: ObservableObject {

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

        if interactor.isOnboardingComplete {
            router.showTabbarScreen()
        } else {
            router.showOnboardingScreen()
        }
    }
}

// MARK: - Computed Properties
extension SplashPresenter {

}
