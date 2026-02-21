//
//  HomePresenter.swift
//

import SwiftUI
import SwiftfulRouting

enum HomeTab: Int, CaseIterable {
    case favorites, settings
}

@Observable
@MainActor
class HomePresenter {

    // MARK: - Private Properties
    private let interactor: HomeInteractor
    private let router: HomeRouter
    private let entity: HomeEntity
    private let builder: CoreBuilder

    // MARK: - Published Properties
    var selectedTab: HomeTab = .favorites

    // MARK: - Init
    init(
        interactor: HomeInteractor,
        router: HomeRouter,
        entity: HomeEntity,
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
extension HomePresenter {

}
