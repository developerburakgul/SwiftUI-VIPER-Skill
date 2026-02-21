//
//  __ModuleName__Interactor.swift
//

import Foundation

@MainActor
protocol __ModuleName__Interactor {
    /// Define the methods this module needs from CoreInteractor
    /// Example: func fetchItems() async throws -> [ItemModel]
}

// MARK: - CoreInteractor Conformance
extension CoreInteractor: __ModuleName__Interactor {

}
