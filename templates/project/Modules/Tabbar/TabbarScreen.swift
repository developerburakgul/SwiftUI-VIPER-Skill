//
//  TabbarScreen.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import SwiftfulRouting

struct TabbarScreen: View {

    @State var presenter: TabbarPresenter

    var body: some View {
        TabView(selection: $presenter.selectedTab) {
            Tab(value: TabbarTab.home) {
                RouterView { router in
                    presenter.buildHomeScreen(router: router)
                }
            } label: {
                Label("Home", systemImage: "house.fill")
            }

            Tab(value: TabbarTab.favorites) {
                RouterView { router in
                    presenter.buildFavoritesScreen(router: router)
                }
            } label: {
                Label("Favorites", systemImage: "heart.fill")
            }

            Tab(value: TabbarTab.settings) {
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

    RouterView { router in
    builder.tabbarScreen(router: router)
    }
}
