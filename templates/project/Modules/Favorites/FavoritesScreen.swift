//
//  FavoritesScreen.swift
//

import SwiftUI
import SwiftfulRouting

struct FavoritesScreen: View {

    @State var presenter: FavoritesPresenter

    var body: some View {
        contentView
    }

    private var contentView: some View {
        Text("Favorites")
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    return RouterView { router in
        builder.favoritesScreen(router: router)
    }
}
