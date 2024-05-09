//
//  SplashScreen.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 06/05/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var animationComplete = false
    var body: some View {
        ZStack {
            LinearGradient(
                       gradient: Gradient(colors: [Color(hex: AppUserInterface.Colors.gradientColor1), Color(hex: AppUserInterface.Colors.gradientColor1), Color(hex: AppUserInterface.Colors.gradientColor3)]),
                       startPoint: .top,
                       endPoint: .bottom
                   )
            .animation(
                Animation.linear(duration: 3)
                    .repeatForever(autoreverses: false)
            )
            .ignoresSafeArea(.all)
            
            Image("logo")
                .scaleEffect(animationComplete ? 1.5 : 1)
                .opacity(animationComplete ? 0 : 1)
                .animation(.easeInOut(duration: 1))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
                        withAnimation {
                            self.animationComplete = true
                        }
                    }
                }
        }
    }
}

#Preview {
    SplashScreen()
}
