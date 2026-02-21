//
//  OnboardingServiceProtocol.swift
//

import Foundation

protocol OnboardingServiceProtocol: Sendable {
    func hasCompletedOnboarding() -> Bool
    func setOnboardingCompleted()
}
