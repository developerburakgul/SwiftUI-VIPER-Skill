//
//  SettingsPresenter.swift
//

import SwiftUI

@Observable
@MainActor
class SettingsPresenter {

    // MARK: - Private Properties
    private let interactor: SettingsInteractor
    private let router: SettingsRouter
    private let entity: SettingsEntity

    // MARK: - Published Properties

    // MARK: - Init
    init(
        interactor: SettingsInteractor,
        router: SettingsRouter,
        entity: SettingsEntity
    ) {
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    // MARK: - Actions
}

// MARK: - Computed Properties
extension SettingsPresenter {

}
