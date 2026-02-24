//
//  UserSetupInteractor.swift
//  Created by __Username__ on __Date__
//

import Foundation

@MainActor
protocol UserSetupInteractor {
    func markOnboardingComplete()
}

extension CoreInteractor: UserSetupInteractor { }
