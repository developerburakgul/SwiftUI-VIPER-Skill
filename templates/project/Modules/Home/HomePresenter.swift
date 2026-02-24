//
//  HomePresenter.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

@MainActor
class HomePresenter: ObservableObject {

    // MARK: - Private Properties
    private let interactor: HomeInteractor
    private let router: HomeRouter
    private let entity: HomeEntity

    // MARK: - Published Properties

    // MARK: - Init
    init(
        interactor: HomeInteractor,
        router: HomeRouter,
        entity: HomeEntity
    ) {
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    // MARK: - Actions
}

// MARK: - Computed Properties
extension HomePresenter {

}
