//
//  SettingsScreen.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import SwiftfulRouting

struct SettingsScreen: View {

    @State var presenter: SettingsPresenter

    var body: some View {
        contentView
    }

    private var contentView: some View {
        Text("Settings")
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    return RouterView { router in
        builder.settingsScreen(router: router)
    }
}
