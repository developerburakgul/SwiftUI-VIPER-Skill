//
//  TabbarScreen.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import SwiftfulRouting

struct TabbarScreen: View {

    @StateObject var presenter: TabbarPresenter

    var body: some View {
        TabView(selection: $presenter.selectedTab) {
            RouterView { router in
                presenter.buildHomeScreen(router: router)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(TabbarTab.home)

            RouterView { router in
                presenter.buildFavoritesScreen(router: router)
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
            .tag(TabbarTab.favorites)

            RouterView { router in
                presenter.buildSettingsScreen(router: router)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
            .tag(TabbarTab.settings)
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
