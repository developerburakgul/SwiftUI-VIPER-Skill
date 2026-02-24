//
//  SplashRouter.swift
//  Created by __Username__ on __Date__
//

import Foundation
import SwiftfulRouting

@MainActor
protocol SplashRouter {
    func showOnboardingScreen(_ entity: OnboardingEntity)
    func showTabbarScreen(_ entity: TabbarEntity)
}

extension CoreRouter: SplashRouter { }
