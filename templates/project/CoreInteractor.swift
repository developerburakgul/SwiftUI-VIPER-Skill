//
//  CoreInteractor.swift
//

import SwiftUI
import DependencyContainer

@MainActor
struct CoreInteractor {

    init(container: DependencyContainer) {
        // TODO: Resolve managers as needed
        // self.authManager = container.resolve(AuthManager.self)!
    }

    // MARK: - Add manager methods here
    // Each module defines a protocol for what it needs.
    // CoreInteractor conforms via extension in the module's Interactor file.
}
