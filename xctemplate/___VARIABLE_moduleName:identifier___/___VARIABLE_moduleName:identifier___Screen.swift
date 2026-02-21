//
//  ___VARIABLE_moduleName:identifier___Screen.swift
//  Created by ___USERNAME___ on ___DATE___
//

import SwiftUI

struct ___VARIABLE_moduleName:identifier___Screen: View {

    @State var presenter: ___VARIABLE_moduleName:identifier___Presenter

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
        Text("___VARIABLE_moduleName:identifier___")
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    return RouterView { router in
        builder.___VARIABLE_moduleName:identifier___Screen(router: router)
    }
}