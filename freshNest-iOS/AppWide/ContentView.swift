//
//  ContentView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 06/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = false
    var body: some View {
        ZStack {
            if showOnboarding {
                OnboardingView()
                    .preferredColorScheme(.light)
            } else {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.showOnboarding = true
                            }
                        }
                    }
            }
//            AccountsView()
//                .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
}
