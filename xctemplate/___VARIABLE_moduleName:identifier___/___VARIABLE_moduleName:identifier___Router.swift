//
//  ___VARIABLE_moduleName:identifier___Router.swift
//  Created by ___USERNAME___ on ___DATE___
//
import Foundation
import SwiftfulRouting

@MainActor
protocol ___VARIABLE_moduleName:identifier___Router {
    /// Define the navigation this module needs from CoreRouter
    /// Example: func showDetailScreen(entity: DetailEntity)
    func showNextScreen()
}

// TODO: Move the implementation to CoreRouter
extension CoreRouter: ___VARIABLE_moduleName:identifier___Router {
    func showNextScreen() {

    }
}