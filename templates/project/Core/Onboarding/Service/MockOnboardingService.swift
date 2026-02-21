//
//  MockOnboardingService.swift
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
