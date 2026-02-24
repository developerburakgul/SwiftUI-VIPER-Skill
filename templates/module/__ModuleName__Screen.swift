//
//  __ModuleName__Screen.swift
//  Created by __USERNAME__ on __DATE__
//

import SwiftUI

struct __ModuleName__Screen: View {

    @StateObject var presenter: __ModuleName__Presenter

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

    RouterView { router in
        builder.__moduleName__Screen(router: router)
    }
}
