//
//  SplashRouter.swift
//  Created by __Username__ on __Date__
//

import Foundation
import SwiftfulRouting

@MainActor
protocol SplashRouter {
    func showOnboardingScreen()
    func showHomeScreen()
}

extension CoreRouter: SplashRouter { }
