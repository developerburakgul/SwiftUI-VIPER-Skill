//
//  OnboardingInteractor.swift
//

import Foundation

@MainActor
protocol OnboardingInteractor {
    var hasCompletedOnboarding: Bool { get }
    func completeOnboarding()
}

extension CoreInteractor: OnboardingInteractor { }
