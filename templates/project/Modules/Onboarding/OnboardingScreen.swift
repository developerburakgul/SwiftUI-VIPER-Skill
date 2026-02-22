//
//  OnboardingScreen.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import SwiftfulRouting

struct OnboardingScreen: View {

    @State var presenter: OnboardingPresenter

    var body: some View {
        contentView
            .task {

            }
    }

    private var contentView: some View {
        ZStack {
            __AppName__Design.Background.primary.ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "hand.wave.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(__AppName__Design.Accent.primary)

                Text("__AppName__'a Hoş Geldiniz")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(__AppName__Design.Foreground.primary)

                Text("Başlamak için aşağıdaki butona tıklayın.")
                    .font(.body)
                    .foregroundStyle(__AppName__Design.Foreground.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer()

                Button {
                    presenter.onCompletePressed()
                } label: {
                    Text("Başla")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(__AppName__Design.Accent.primary)
                        .foregroundStyle(__AppName__Design.Background.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    RouterView { router in
        builder.onboardingScreen(router: router)
    }
}
