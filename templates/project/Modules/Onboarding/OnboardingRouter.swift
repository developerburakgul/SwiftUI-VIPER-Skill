//
//  OnboardingRouter.swift
//

import Foundation
import SwiftfulRouting

@MainActor
protocol OnboardingRouter {
    func showHomeScreen()
}

extension CoreRouter: OnboardingRouter { }
