//
//  UserService.swift
//  Created by __Username__ on __Date__
//

import Foundation

struct UserService: UserServiceProtocol {

    private let key = "isOnboardingComplete"

    func isOnboardingComplete() -> Bool {
        UserDefaults.standard.bool(forKey: key)
    }

    func markOnboardingComplete() {
        UserDefaults.standard.set(true, forKey: key)
    }
}
