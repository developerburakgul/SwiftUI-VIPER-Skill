//
//  SplashRouter.swift
//

import Foundation
import SwiftfulRouting

@MainActor
protocol SplashRouter {
    // MARK: - Segues
    func showOnboardingScreen()
    func showHomeScreen()
}

extension CoreRouter: SplashRouter { }
