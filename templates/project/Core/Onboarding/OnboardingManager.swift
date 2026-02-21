//
//  OnboardingManager.swift
//

import SwiftUI

@Observable
class OnboardingManager {

    private let service: OnboardingServiceProtocol
    private(set) var hasCompleted: Bool

    init(service: OnboardingServiceProtocol) {
        self.service = service
        self.hasCompleted = service.hasCompletedOnboarding()
    }

    // MARK: - Public Methods

    func completeOnboarding() {
        service.setOnboardingCompleted()
        hasCompleted = true
    }
}
