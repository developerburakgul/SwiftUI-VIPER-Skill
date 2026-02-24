//
//  UserService.swift
//  Created by __Username__ on __Date__
//

import Foundation

struct UserService: UserServiceProtocol {

    private let onboardingKey = "isOnboardingComplete"
    private let lastTabKey = "lastSelectedTab"

    func isOnboardingComplete() -> Bool {
        UserDefaults.standard.bool(forKey: onboardingKey)
    }

    func markOnboardingComplete() {
        UserDefaults.standard.set(true, forKey: onboardingKey)
    }

    func lastSelectedTab() -> Int? {
        let value = UserDefaults.standard.object(forKey: lastTabKey) as? Int
        return value
    }

    func saveLastSelectedTab(_ tabIndex: Int) {
        UserDefaults.standard.set(tabIndex, forKey: lastTabKey)
    }
}
