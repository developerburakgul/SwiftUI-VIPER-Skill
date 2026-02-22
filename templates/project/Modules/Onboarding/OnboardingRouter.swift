//
//  OnboardingRouter.swift
//  Created by __Username__ on __Date__
//

import Foundation
import SwiftfulRouting

@MainActor
protocol OnboardingRouter {
    func showTabbarScreen()
}

extension CoreRouter: OnboardingRouter { }
