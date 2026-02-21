//
//  HomeScreen.swift
//

import SwiftUI
import SwiftfulRouting

struct HomeScreen: View {

    @State var presenter: HomePresenter

    var body: some View {
        TabView(selection: $presenter.selectedTab) {
            Tab(value: HomeTab.favorites) {
                RouterView { router in
                    presenter.buildFavoritesScreen(router: router)
                }
            } label: {
                Label("Favorites", systemImage: "heart.fill")
            }

            Tab(value: HomeTab.settings) {
                RouterView { router in
                    presenter.buildSettingsScreen(router: router)
                }
            } label: {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    return builder.homeScreen(router: Router(paths: .constant(.init())))
}
