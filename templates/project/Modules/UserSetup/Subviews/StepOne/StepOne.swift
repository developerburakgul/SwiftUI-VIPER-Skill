//
//  StepOne.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

extension UserSetupScreen {

    struct StepOne: View, @MainActor Equatable {

        enum Action {
            case didTapNext
        }

        @Binding var binding: StepOneEntity.Binding
        let config: StepOneEntity.Config
        let onAction: (Action) -> Void

        var body: some View {
            VStack(spacing: 24) {
                Spacer()

                Text(config.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(__AppName__Design.Foreground.primary)

                Text(config.subtitle)
                    .font(.body)
                    .foregroundStyle(__AppName__Design.Foreground.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                TextField("Metin girin", text: $binding.inputText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 24)

                Spacer()

                Button {
                    onAction(.didTapNext)
                } label: {
                    Text("İleri")
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

        static func == (lhs: StepOne, rhs: StepOne) -> Bool {
            lhs.binding == rhs.binding
            && lhs.config == rhs.config
        }
    }
}
