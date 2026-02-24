//
//  FavoritesPresenter.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

@MainActor
class FavoritesPresenter: ObservableObject {

    // MARK: - Private Properties
    private let interactor: FavoritesInteractor
    private let router: FavoritesRouter
    private let entity: FavoritesEntity

    // MARK: - Published Properties

    // MARK: - Init
    init(
        interactor: FavoritesInteractor,
        router: FavoritesRouter,
        entity: FavoritesEntity
    ) {
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    // MARK: - Actions
}

// MARK: - Computed Properties
extension FavoritesPresenter {

}
