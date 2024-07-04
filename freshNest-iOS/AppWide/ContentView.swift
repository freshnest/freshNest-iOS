//
//  ContentView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 06/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplashScreen = true
    @AppStorage("isAuthenticated") var isAuthenticated = false
    @EnvironmentObject var supabaseClient: SupabaseManager

    var body: some View {
        Group {
            if showSplashScreen {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                self.showSplashScreen = false
                            }
                        }
                    }
            } else {
                if isAuthenticated {
                    MainView()
                        .onAppear {
                            supabaseClient.fetchUserData()
                            supabaseClient.fetchScheduledJobs()
                            supabaseClient.fetchAvailableJobsWithoutLoader()
                        }
                        .preferredColorScheme(.light)
                } else {
                    OnboardingView()
                        .preferredColorScheme(.light)
                }
            }
//            WorkFlowView()
//                .preferredColorScheme(.light)
        }
//        .task {
//            for await state in await supabaseClient.supabase.auth.authStateChanges {
//                if [.initialSession, .signedIn, .signedOut].contains(state.event) {
//                    supabaseClient.isAuthenticated = state.session != nil
//                    isAuthenticated = supabaseClient.isAuthenticated
//                }
//            }
//        }
    }
}

#Preview {
    ContentView()
}
