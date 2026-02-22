//
//  SettingsScreen.swift
//  Created by __Username__ on __Date__
//

import DynamicColor
import SwiftUI
import SwiftfulRouting

struct SettingsScreen: View {

    @State var presenter: SettingsPresenter
    @ObservedObject private var themeStore = ThemeStore.shared

    var body: some View {
        contentView
    }

    private var contentView: some View {
        ZStack {
            __AppName__Design.Background.primary.ignoresSafeArea()

            List {
                // Tema ayarı
                Section {
                    Picker("Tema", selection: $themeStore.theme) {
                        Text("Sistem").tag(AppTheme.system)
                        Text("Açık").tag(AppTheme.light)
                        Text("Koyu").tag(AppTheme.dark)
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Görünüm")
                }

                // TODO: Diğer ayarlar buraya eklenecek
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    return RouterView { router in
        builder.settingsScreen(router: router)
    }
}
