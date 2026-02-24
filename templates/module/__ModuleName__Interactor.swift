//
//  __ModuleName__Interactor.swift
//  Created by __USERNAME__ on __DATE__
//

import Foundation

@MainActor
protocol __ModuleName__Interactor {
    /// Define the methods this module needs from CoreInteractor
    /// Example: func fetchItems() async throws -> [ItemModel]
    func fetchData() async throws
}

// TODO: Move the implementation to CoreInteractor
extension CoreInteractor: __ModuleName__Interactor {
    func fetchData() async throws {

    }
}
