//
//  __ModuleName__Router.swift
//

import Foundation
import SwiftfulRouting

@MainActor
protocol __ModuleName__Router {
    /// Define the navigation this module needs from CoreRouter
    /// Example: func showDetailScreen(entity: DetailEntity)

    // MARK: - Segues

    // MARK: - Modals
    func dismissModal()
    func dismissScreen()

    // MARK: - Alerts
    func showAlert(error: Error)
}

// MARK: - CoreRouter Conformance
extension CoreRouter: __ModuleName__Router {

}
