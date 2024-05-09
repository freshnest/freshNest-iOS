//
//  OnboardingView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 06/05/24.
//

import SwiftUI

struct OnboardingIntroductionModel {
    var iconName: String
    var titleText: String
    var titleColor: Color
}

struct OnboardingView: View {
    @State private var currentIndex = 0
    @State private var showSignUpScreen = false
    @State var appear = false
    let texts = ["Clean when you want", "Earn what you need"]
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                ZStack(alignment: .center) {
                    ForEach(0..<texts.count, id: \.self) { index in
                        FadeInOutView(text: self.texts[index], startTime: 0.05, opacity: Binding(get: {
                            self.currentIndex == index ? 1 : 0
                        }, set: { _ in }))
                    }
                }
                .background(
                    ZStack {
                        AngularGradient(colors: [Color(hex: AppUserInterface.Colors.gradientColor1), Color(hex: AppUserInterface.Colors.gradientColor2), Color(hex: AppUserInterface.Colors.gradientColor3)], center: .center, angle: .degrees(appear ? 360 : 0))
                            .cornerRadius(30)
                            .blur(radius: 15)
                            .opacity(0.8)
                    }
                ).padding(.vertical, 32)
                .onAppear {
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                        appear = true
                    }
                }
                .transition(.slide)
                Image("onboarding1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 360)
                    .padding(.vertical, 32)
                
                Spacer()
                
                if currentIndex == 1 {
                    VStack(spacing: 16) {
                        RoundedButton(title: "Get Started", action: {
                            // signup action
                            showSignUpScreen.toggle()
                        }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
                    }
                    .padding(.horizontal, 16)
                } else {
                    RoundedButton(title: "Next", action: {
                        if currentIndex < 2 {
                            currentIndex += 1
                            print("Current Index: \(currentIndex)")
                        }
                    }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
                    .padding(.horizontal, 16)
                }
                    
            }
            .padding(16)
        }
        .fullScreenCover(isPresented: $showSignUpScreen, content: {
            SignUpView()
        })
    }
}

#Preview {
    OnboardingView()
}
