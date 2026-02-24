//
//  OnboardingRouter.swift
//  Created by __Username__ on __Date__
//

import Foundation
import SwiftfulRouting

@MainActor
protocol OnboardingRouter {
    func showTabbarScreen(_ entity: TabbarEntity)
}

extension CoreRouter: OnboardingRouter { }
