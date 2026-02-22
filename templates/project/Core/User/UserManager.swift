//
//  UserManager.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

@Observable
class UserManager {

    private let service: UserServiceProtocol
    private(set) var isOnboardingComplete: Bool

    init(service: UserServiceProtocol) {
        self.service = service
        self.isOnboardingComplete = service.isOnboardingComplete()
    }

    // MARK: - Public Methods

    func markOnboardingComplete() {
        service.markOnboardingComplete()
        isOnboardingComplete = true
    }
}
