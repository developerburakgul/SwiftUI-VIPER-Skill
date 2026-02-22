//
//  OnboardingInteractor.swift
//  Created by __Username__ on __Date__
//

import Foundation

@MainActor
protocol OnboardingInteractor {
    var isOnboardingComplete: Bool { get }
    func markOnboardingComplete()
}

extension CoreInteractor: OnboardingInteractor { }
