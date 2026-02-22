//
//  MockOnboardingService.swift
//  Created by __Username__ on __Date__
//

import Foundation

struct MockOnboardingService: OnboardingServiceProtocol {

    func hasCompletedOnboarding() -> Bool {
        false
    }

    func setOnboardingCompleted() {
        // Mock: işlem yok
    }
}
