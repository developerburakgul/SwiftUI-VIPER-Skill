//
//  FavoritesScreen.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import SwiftfulRouting

struct FavoritesScreen: View {

    @State var presenter: FavoritesPresenter

    var body: some View {
        contentView
    }

    private var contentView: some View {
        ZStack {
            __AppName__Design.Background.primary.ignoresSafeArea()

            Text("Favorites")
                .foregroundStyle(__AppName__Design.Foreground.primary)
        }
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    RouterView { router in
        builder.favoritesScreen(router: router)
    }
}
