//
//  CoreInteractor.swift
//

import SwiftUI
import DependencyContainer

@MainActor
struct CoreInteractor {
    private let appState: AppState

    init(container: DependencyContainer) {
        self.appState = container.resolve(AppState.self)!
        // TODO: Resolve other managers as needed
        // self.authManager = container.resolve(AuthManager.self)!
    }

    // MARK: - AppState

    var showTabBar: Bool {
        appState.showTabBar
    }

    func updateAppState(showTabBarView: Bool) {
        appState.updateViewState(showTabBarView: showTabBarView)
    }

    // MARK: - Add manager methods here
    // Each module defines a protocol for what it needs.
    // CoreInteractor conforms via extension in the module's Interactor file.
}
