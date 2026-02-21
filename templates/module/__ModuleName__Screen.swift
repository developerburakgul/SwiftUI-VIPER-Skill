//
//  __ModuleName__Screen.swift
//

import SwiftUI

struct __ModuleName__Screen: View {

    @State var presenter: __ModuleName__Presenter

    var body: some View {
        contentView
            .task {

            }
            .onAppear {

            }
            .onDisappear {

            }
    }

    private var contentView: some View {
        Text("__ModuleName__")
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    return RouterView { router in
        builder.__moduleName__Screen(router: router)
    }
}
