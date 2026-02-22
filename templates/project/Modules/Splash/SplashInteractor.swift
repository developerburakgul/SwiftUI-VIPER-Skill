//
//  SplashInteractor.swift
//  Created by __Username__ on __Date__
//

import Foundation

@MainActor
protocol SplashInteractor {
    var isOnboardingComplete: Bool { get }
    func performStartupTasks() async
}

extension CoreInteractor: SplashInteractor { }
