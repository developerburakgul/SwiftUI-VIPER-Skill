//
//  __ModuleName__Presenter.swift
//

import SwiftUI

@Observable
@MainActor
class __ModuleName__Presenter {

    // MARK: - Private Properties
    private let interactor: __ModuleName__Interactor
    private let router: __ModuleName__Router
    private let entity: __ModuleName__Entity

    // MARK: - Published Properties

    // MARK: - Init
    init(
        interactor: __ModuleName__Interactor,
        router: __ModuleName__Router,
        entity: __ModuleName__Entity
    ) {
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    // MARK: - Actions

}

// MARK: - Computed Properties
extension __ModuleName__Presenter {

}
