//
//  IntroScreen.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import SwiftfulRouting

struct IntroScreen: View {

    @StateObject var presenter: IntroPresenter

    var body: some View {
        contentView
    }

    private var contentView: some View {
        ZStack(alignment: .bottom) {
            __AppName__Design.Background.primary.ignoresSafeArea()

            TabView(selection: $presenter.currentPage) {
                ForEach(presenter.pages.indices, id: \.self) { index in
                    IntroPage(config: presenter.pages[index].config)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))

            if presenter.isLastPage {
                Button {
                    presenter.onGetStartedPressed()
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
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: presenter.isLastPage)
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    RouterView { router in
        builder.introScreen(router: router)
    }
}
