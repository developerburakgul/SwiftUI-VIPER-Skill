//
//  __ModuleName__Router.swift
//  Created by __USERNAME__ on __DATE__
//
import Foundation
import SwiftfulRouting

@MainActor
protocol __ModuleName__Router {
    /// Define the navigation this module needs from CoreRouter
    /// Example: func showDetailScreen(entity: DetailEntity)
    func showNextScreen()
}

// TODO: Move the implementation to CoreRouter
extension CoreRouter: __ModuleName__Router {
    func showNextScreen() {

    }
}
