//
//  IntroPresenter.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

@MainActor
class IntroPresenter: ObservableObject {

    // MARK: - Private Properties
    private let interactor: IntroInteractor
    private let router: IntroRouter
    private let entity: IntroEntity

    // MARK: - Published Properties
    @Published var currentPage: Int = 0
    @Published private(set) var pages: [IntroScreen.IntroPageEntity] = [
        .init(config: .init(icon: "star.fill", title: "Hoş Geldiniz", description: "Uygulama tanıtım metni 1")),
        .init(config: .init(icon: "heart.fill", title: "Keşfedin", description: "Uygulama tanıtım metni 2")),
        .init(config: .init(icon: "bolt.fill", title: "Başlayın", description: "Uygulama tanıtım metni 3"))
    ]

    // MARK: - Init
    init(
        interactor: IntroInteractor,
        router: IntroRouter,
        entity: IntroEntity
    ) {
        self.interactor = interactor
        self.router = router
        self.entity = entity
    }

    // MARK: - Actions

    func onGetStartedPressed() {
        router.showUserSetupScreen(UserSetupEntity())
    }
}

// MARK: - Computed Properties
extension IntroPresenter {

    var isLastPage: Bool {
        currentPage == pages.count - 1
    }
}
