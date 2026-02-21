//
//  ___VARIABLE_moduleName:identifier___Interactor.swift
//  Created by ___USERNAME___ on ___DATE___
//

import Foundation

@MainActor
protocol ___VARIABLE_moduleName:identifier___Interactor {
    /// Define the methods this module needs from CoreInteractor
    /// Example: func fetchItems() async throws -> [ItemModel]
    func fetchData() async throws
}

// TODO: Move the implementation to CoreInteractor
extension CoreInteractor: ___VARIABLE_moduleName:identifier___Interactor {
    func fetchData() async throws {

    }
}