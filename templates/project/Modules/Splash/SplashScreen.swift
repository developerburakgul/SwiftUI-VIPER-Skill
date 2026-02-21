//
//  SplashScreen.swift
//

import SwiftUI
import SwiftfulRouting

struct SplashScreen: View {

    @State var presenter: SplashPresenter

    var body: some View {
        contentView
            .task {
                await presenter.onAppear()
            }
    }

    private var contentView: some View {
        VStack {
            Spacer()

            // TODO: App icon veya logo ekleyin
            Image(systemName: "app.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    return RouterView { router in
        builder.splashScreen(router: router)
    }
}
