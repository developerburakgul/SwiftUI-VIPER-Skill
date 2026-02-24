//
//  UserSetupRouter.swift
//  Created by __Username__ on __Date__
//

import Foundation
import SwiftfulRouting

@MainActor
protocol UserSetupRouter {
    func showTabbarScreen(_ entity: TabbarEntity)
}

extension CoreRouter: UserSetupRouter { }
