//
//  IntroRouter.swift
//  Created by __Username__ on __Date__
//

import Foundation
import SwiftfulRouting

@MainActor
protocol IntroRouter {
    func showUserSetupScreen(_ entity: UserSetupEntity)
}

extension CoreRouter: IntroRouter { }
