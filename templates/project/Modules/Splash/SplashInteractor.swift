//
//  SplashInteractor.swift
//

import Foundation

@MainActor
protocol SplashInteractor {
    var hasCompletedOnboarding: Bool { get }
    func performStartupTasks() async
}

extension CoreInteractor: SplashInteractor { }
