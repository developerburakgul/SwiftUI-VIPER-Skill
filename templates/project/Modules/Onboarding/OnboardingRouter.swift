//
//  OnboardingRouter.swift
//  Created by __Username__ on __Date__
//

import Foundation
import SwiftfulRouting

@MainActor
protocol OnboardingRouter {
    func showTabbarScreen(entity: TabbarEntity)
}

extension OnboardingRouter {
    func showTabbarScreen() {
        showTabbarScreen(entity: TabbarEntity())
    }
}

extension CoreRouter: OnboardingRouter { }
