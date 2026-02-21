//
//  ___VARIABLE_viewName:identifier___.swift
//  Created by ___USERNAME___ on ___DATE___
//

import SwiftUI

struct ___VARIABLE_viewName:identifier___: View, @MainActor Equatable {

    enum Action { 
        case didTapText
    }

    @Binding var binding: ___VARIABLE_viewName:identifier___Entity.Binding
    let config: ___VARIABLE_viewName:identifier___Entity.Config

    let onAction: (Action) -> Void

    var body: some View {
        Text("Hello World")
            .onTapGesture {
                onAction(.didTapText)
            }
    }
        
    static func == (lhs: ___VARIABLE_viewName:identifier___, rhs: ___VARIABLE_viewName:identifier___) -> Bool {
        lhs.binding == rhs.binding
        && lhs.config == rhs.config
    }
}
