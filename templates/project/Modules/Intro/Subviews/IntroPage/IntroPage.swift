//
//  IntroPage.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

extension IntroScreen {

    struct IntroPage: View, @MainActor Equatable {

        let config: IntroPageEntity.Config

        var body: some View {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: config.icon)
                    .font(.system(size: 64))
                    .foregroundStyle(__AppName__Design.Accent.primary)

                Text(config.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(__AppName__Design.Foreground.primary)

                Text(config.description)
                    .font(.body)
                    .foregroundStyle(__AppName__Design.Foreground.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer()
            }
        }

        static func == (lhs: IntroPage, rhs: IntroPage) -> Bool {
            lhs.config == rhs.config
        }
    }
}
