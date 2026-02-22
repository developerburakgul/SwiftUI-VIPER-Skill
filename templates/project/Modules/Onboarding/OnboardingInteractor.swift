//
//  OnboardingInteractor.swift
//  Created by __Username__ on __Date__
//

import Foundation

@MainActor
protocol OnboardingInteractor {
    var hasCompletedOnboarding: Bool { get }
    func completeOnboarding()
}

extension CoreInteractor: OnboardingInteractor { }
