//
//  SplashRouter.swift
//  Created by __Username__ on __Date__
//

import Foundation
import SwiftfulRouting

@MainActor
protocol SplashRouter {
    func showIntroScreen(_ entity: IntroEntity)
    func showTabbarScreen(_ entity: TabbarEntity)
}

extension CoreRouter: SplashRouter { }
