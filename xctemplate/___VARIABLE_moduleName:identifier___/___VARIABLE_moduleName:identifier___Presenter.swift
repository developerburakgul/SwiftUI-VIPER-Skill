//
//  ___VARIABLE_moduleName:identifier___Presenter.swift
//  Created by ___USERNAME___ on ___DATE___
//

import SwiftUI

@Observable
@MainActor
class ___VARIABLE_moduleName:identifier___Presenter {

    // MARK: - Private Properties
    private let interactor: ___VARIABLE_moduleName:identifier___Interactor
    private let router: ___VARIABLE_moduleName:identifier___Router
    private let entity: ___VARIABLE_moduleName:identifier___Entity

    // MARK: - Published Properties

    // MARK: - Init
    init(
        interactor: ___VARIABLE_moduleName:identifier___Interactor,
        router: ___VARIABLE_moduleName:identifier___Router,
        entity: ___VARIABLE_moduleName:identifier___Entity
    ) {
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    // MARK: - Actions

}

// MARK: - Computed Properties
extension ___VARIABLE_moduleName:identifier___Presenter {

}