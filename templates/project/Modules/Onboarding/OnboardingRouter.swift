//
//  OnboardingRouter.swift
//

import Foundation
import SwiftfulRouting

@MainActor
protocol OnboardingRouter {
    // Onboarding'den çıkış CoreBuilder seviyesinde yönetilir
}

extension CoreRouter: OnboardingRouter { }
