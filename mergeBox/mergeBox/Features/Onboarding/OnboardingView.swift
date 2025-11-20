//
//  OnboardingView.swift
//  mergeBox
//
//  Created by 松浦壮吾 on 2025/10/21.
//

import Lottie
import SwiftUI

/**
 Userdefaultに初期起動フラグがfalseの場合このViewが表示される
 */

struct OnboardingView: View {

    @State var viewModel: OnboardingViewModel
    init(viewModel: OnboardingViewModel = OnboardingViewModel()) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.router.path) {
            TabView(selection: $viewModel.selection) {
                ForEach(viewModel.onboardingValues, id: \.id) { onBoardingValue in
                    LottieCardView(
                        animation: onBoardingValue.animation,
                        title: onBoardingValue.title,
                        subtitle: onBoardingValue.subtitle,
                        tag: onBoardingValue.tag
                    )
                    .padding(.horizontal, 24)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            Button(viewModel.nextButtonText) {
                withAnimation {
                    viewModel.handle(.nextButtonPressed)
                }
            }
            .buttonStyle(
                .customButtonStyle(
                    foregroundColor: .white,
                    backgroundColor: .blue,
                    fontSize: .default,
                    height: 50,
                    width: .infinity
                )
            )
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            .navigationDestination(for: AuthRoute.self) { route in
                switch route {
                case .login:
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct LottieCardView: View {
    let id = UUID()
    let animation: LottieAnimation
    let title: String
    let subtitle: String
    let tag: Int
    var body: some View {
        VStack(spacing: 20) {
            LottieView(animation: animation)
                .playing()
                .looping()
                .frame(width: 350, height: 400)
            Text(title)
                .bold()
            Text(subtitle)

        }
        .multilineTextAlignment(.center)
        .tag(tag)
    }
}

#Preview {
    OnboardingView()
}
