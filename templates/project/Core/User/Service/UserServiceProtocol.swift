//
//  UserServiceProtocol.swift
//  Created by __Username__ on __Date__
//

import Foundation

protocol UserServiceProtocol: Sendable {
    func isOnboardingComplete() -> Bool
    func markOnboardingComplete()
    func lastSelectedTab() -> Int?
    func saveLastSelectedTab(_ tabIndex: Int)
}
