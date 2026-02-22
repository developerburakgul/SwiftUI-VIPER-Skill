//
//  OnboardingService.swift
//  Created by __Username__ on __Date__
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
