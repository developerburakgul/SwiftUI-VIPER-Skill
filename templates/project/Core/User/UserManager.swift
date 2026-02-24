//
//  UserManager.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

class UserManager: ObservableObject {

    private let service: UserServiceProtocol
    @Published private(set) var isOnboardingComplete: Bool

    init(service: UserServiceProtocol) {
        self.service = service
        self.isOnboardingComplete = service.isOnboardingComplete()
    }

    // MARK: - Public Methods

    func markOnboardingComplete() {
        service.markOnboardingComplete()
        isOnboardingComplete = true
    }

    func lastSelectedTab() -> Int? {
        service.lastSelectedTab()
    }

    func saveLastSelectedTab(_ tabIndex: Int) {
        service.saveLastSelectedTab(tabIndex)
    }
}
