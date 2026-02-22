//
//  OnboardingPresenter.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

@Observable
@MainActor
class OnboardingPresenter {

    // MARK: - Private Properties
    private let interactor: OnboardingInteractor
    private let router: OnboardingRouter
    private let entity: OnboardingEntity

    // MARK: - Published Properties

    // MARK: - Init
    init(
        interactor: OnboardingInteractor,
        router: OnboardingRouter,
        entity: OnboardingEntity
    ) {
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    // MARK: - Actions

    func onCompletePressed() {
        interactor.markOnboardingComplete()
        router.showHomeScreen()
    }
}

// MARK: - Computed Properties
extension OnboardingPresenter {

}
