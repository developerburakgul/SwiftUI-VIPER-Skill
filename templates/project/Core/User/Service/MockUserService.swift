//
//  MockUserService.swift
//  Created by __Username__ on __Date__
//

import Foundation

struct MockUserService: UserServiceProtocol {

    func isOnboardingComplete() -> Bool {
        false
    }

    func markOnboardingComplete() {
        // Mock: işlem yok
    }
}
