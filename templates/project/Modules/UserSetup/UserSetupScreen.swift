//
//  UserSetupScreen.swift
//  Created by __Username__ on __Date__
//

import SwiftUI
import SwiftfulRouting

struct UserSetupScreen: View {

    @StateObject var presenter: UserSetupPresenter

    var body: some View {
        contentView
            .animation(.easeInOut, value: presenter.currentStep)
    }

    private var contentView: some View {
        ZStack {
            __AppName__Design.Background.primary.ignoresSafeArea()

            VStack(spacing: 0) {
                headerView

                stepContent
                    .frame(maxHeight: .infinity)
            }
        }
    }

    private var headerView: some View {
        HStack {
            if !presenter.isFirstStep {
                Button {
                    presenter.onBackPressed()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundStyle(__AppName__Design.Foreground.primary)
                }
            }

            Spacer()

            Text("\(presenter.currentStep + 1)/\(presenter.totalSteps)")
                .font(.subheadline)
                .foregroundStyle(__AppName__Design.Foreground.secondary)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
    }

    @ViewBuilder
    private var stepContent: some View {
        switch presenter.currentStep {
        case 0:
            StepOne(
                binding: $presenter.stepOne.binding,
                config: presenter.stepOne.config,
                onAction: presenter.onStepOneAction
            )
        case 1:
            StepTwo(
                binding: $presenter.stepTwo.binding,
                config: presenter.stepTwo.config,
                onAction: presenter.onStepTwoAction
            )
        case 2:
            StepThree(
                binding: $presenter.stepThree.binding,
                config: presenter.stepThree.config,
                onAction: presenter.onStepThreeAction
            )
        default:
            EmptyView()
        }
    }
}

#Preview {
    let container = DevPreview.shared.container
    let builder = CoreBuilder(interactor: CoreInteractor(container: container))

    RouterView { router in
        builder.userSetupScreen(router: router)
    }
}
