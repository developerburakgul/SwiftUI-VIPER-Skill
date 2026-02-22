//
//  SplashRouter.swift
//  Created by __Username__ on __Date__
//

import Foundation
import SwiftfulRouting

@MainActor
protocol SplashRouter {
    // MARK: - Segues
    func showOnboardingScreen(entity: OnboardingEntity)
    func showHomeScreen(entity: HomeEntity)
}

extension CoreRouter: SplashRouter { }
