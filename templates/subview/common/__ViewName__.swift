//
//  __ViewName__.swift
//

import SwiftUI

struct __ViewName__: View, @MainActor Equatable {

    enum Action {
        case didTapText
    }

    @Binding var binding: __ViewName__Entity.Binding
    let config: __ViewName__Entity.Config

    let onAction: (Action) -> Void

    var body: some View {
        Text("Hello World")
            .onTapGesture {
                onAction(.didTapText)
            }
    }

    static func == (lhs: __ViewName__, rhs: __ViewName__) -> Bool {
        lhs.binding == rhs.binding
        && lhs.config == rhs.config
    }
}
