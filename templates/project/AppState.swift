//
//  AppState.swift
//

import SwiftUI

@Observable
class AppState {
    private(set) var showTabBar: Bool

    init(showTabBar: Bool = false) {
        self.showTabBar = showTabBar
    }

    func updateViewState(showTabBarView: Bool) {
        self.showTabBar = showTabBarView
    }
}
