//
//  OnboardingServiceProtocol.swift
//  Created by __Username__ on __Date__
//

import Foundation

protocol OnboardingServiceProtocol: Sendable {
    func hasCompletedOnboarding() -> Bool
    func setOnboardingCompleted()
}
