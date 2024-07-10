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
    @State private var showAlert = false
    @State private var alertMessage = ""
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
                        .task {
                            await fetchData()
                        }
                        .preferredColorScheme(.light)
                        .alert("Error", isPresented: $showAlert) {
                            Button("OK") {
                                showAlert = false
                            }
                        } message: {
                            Text(alertMessage)
                        }
                } else {
                    OnboardingView()
                        .preferredColorScheme(.light)
                }
            }
            //            WorkFlowView()
            //                .preferredColorScheme(.light)
        }
    }
    private func fetchData() async {
        do {
            try await supabaseClient.fetchUserData()
            supabaseClient.fetchScheduledJobs()
            supabaseClient.fetchAvailableJobsWithoutLoader()
        } catch {
            alertMessage = "Failed to fetch data: \(error.localizedDescription)"
            showAlert = true
        }
    }
}

#Preview {
    ContentView()
}
