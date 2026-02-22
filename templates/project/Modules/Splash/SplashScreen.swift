//
//  SplashScreen.swift
//  Created by __Username__ on __Date__
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
        ZStack {
            // Gradient arka plan
            LinearGradient(
                colors: [
                    __AppName__Design.Splash.gradientStart,
                    __AppName__Design.Splash.gradientMid,
                    __AppName__Design.Splash.gradientEnd
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                // TODO: App icon veya logo ekleyin
                Image(systemName: "app.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.white.opacity(0.9))
                    .shadow(color: .white.opacity(0.3), radius: 20)

                Text("__AppName__")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Spacer()

                ProgressView()
                    .tint(.white.opacity(0.7))
                    .padding(.bottom, 48)
            }
        }
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    RouterView { router in
        builder.splashScreen(router: router)
    }
}
