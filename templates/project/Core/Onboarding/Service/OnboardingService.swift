//
//  OnboardingService.swift
//

import Foundation

struct OnboardingService: OnboardingServiceProtocol {

    private let key = "hasCompletedOnboarding"

    func hasCompletedOnboarding() -> Bool {
        UserDefaults.standard.bool(forKey: key)
    }

    func setOnboardingCompleted() {
        UserDefaults.standard.set(true, forKey: key)
    }
}
