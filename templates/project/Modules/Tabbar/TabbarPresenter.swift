//
//  TabbarPresenter.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import SwiftfulRouting

enum TabbarTab: Int, CaseIterable {
    case favorites, settings
}

@Observable
@MainActor
class TabbarPresenter {

    // MARK: - Private Properties
    private let interactor: TabbarInteractor
    private let router: TabbarRouter
    private let entity: TabbarEntity
    private let builder: CoreBuilder

    // MARK: - Published Properties
    var selectedTab: TabbarTab = .favorites

    // MARK: - Init
    init(
        interactor: TabbarInteractor,
        router: TabbarRouter,
        entity: TabbarEntity,
        builder: CoreBuilder
    ) {
        self.interactor = interactor
        self.router = router
        self.entity = entity
        self.builder = builder
    }

    // MARK: - Tab Builders

    func buildFavoritesScreen(router: Router) -> some View {
        builder.favoritesScreen(router: router)
    }

    func buildSettingsScreen(router: Router) -> some View {
        builder.settingsScreen(router: router)
    }
}

// MARK: - Computed Properties
extension TabbarPresenter {

}
