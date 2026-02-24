//
//  UserSetupPresenter.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

@MainActor
class UserSetupPresenter: ObservableObject {

    // MARK: - Private Properties
    private let interactor: UserSetupInteractor
    private let router: UserSetupRouter
    private let entity: UserSetupEntity

    // MARK: - Published Properties
    @Published var currentStep: Int = 0
    @Published var stepOne: UserSetupScreen.StepOneEntity
    @Published var stepTwo: UserSetupScreen.StepTwoEntity
    @Published var stepThree: UserSetupScreen.StepThreeEntity

    // MARK: - Constants
    let totalSteps = 3

    // MARK: - Init
    init(
        interactor: UserSetupInteractor,
        router: UserSetupRouter,
        entity: UserSetupEntity
    ) {
        self.interactor = interactor
        self.router = router
        self.entity = entity

        self.stepOne = .init(
            binding: .init(inputText: ""),
            config: .init(title: "Adım 1", subtitle: "Birinci adım açıklaması")
        )
        self.stepTwo = .init(
            binding: .init(inputText: ""),
            config: .init(title: "Adım 2", subtitle: "İkinci adım açıklaması")
        )
        self.stepThree = .init(
            binding: .init(inputText: ""),
            config: .init(title: "Adım 3", subtitle: "Üçüncü adım açıklaması")
        )
    }

    // MARK: - Actions

    func onBackPressed() {
        guard !isFirstStep else { return }
        currentStep -= 1
    }

    func onStepOneAction(_ action: UserSetupScreen.StepOne.Action) {
        switch action {
        case .didTapNext:
            currentStep += 1
        }
    }

    func onStepTwoAction(_ action: UserSetupScreen.StepTwo.Action) {
        switch action {
        case .didTapNext:
            currentStep += 1
        }
    }

    func onStepThreeAction(_ action: UserSetupScreen.StepThree.Action) {
        switch action {
        case .didTapComplete:
            interactor.markOnboardingComplete()
            router.showTabbarScreen(TabbarEntity())
        }
    }
}

// MARK: - Computed Properties
extension UserSetupPresenter {

    var isLastStep: Bool {
        currentStep == totalSteps - 1
    }

    var isFirstStep: Bool {
        currentStep == 0
    }
}
