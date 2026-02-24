//
//  TabbarInteractor.swift
//  Created by __Username__ on __Date__
//

import Foundation

@MainActor
protocol TabbarInteractor {
    func saveLastSelectedTab(_ tabIndex: Int)
}

extension CoreInteractor: TabbarInteractor { }
