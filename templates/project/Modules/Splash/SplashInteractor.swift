//
//  SplashInteractor.swift
//  Created by __Username__ on __Date__
//

import Foundation

@MainActor
protocol SplashInteractor {
    var hasCompletedOnboarding: Bool { get }
    func performStartupTasks() async
}

extension CoreInteractor: SplashInteractor { }
