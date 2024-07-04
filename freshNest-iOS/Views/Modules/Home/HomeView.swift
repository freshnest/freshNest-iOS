//
//  HomeView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showScheduledJobs = false
    @State private var showAvailableJobs = false
    @EnvironmentObject var supabaseClient: SupabaseManager
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                MapView()
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hello there, \(supabaseClient.userProfile?.firstName ??  "")!")
                            .font(.cascaded(ofSize: .h32, weight: .bold))
                        Text("You have \(supabaseClient.scheduledJobsCount) jobs scheduled!")
                            .font(.cascaded(ofSize: .h24, weight: .regular))
                    }
                    .padding(.vertical, 16)
                    VStack(spacing: 16) {
                        HStack {
                            Text("Scheduled Jobs")
                                .frame(height: 40)
                                .font(.cascaded(ofSize: .h16, weight: .medium))
                                .foregroundColor(.white)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color(hex: AppUserInterface.Colors.appButtonBlack))
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.2), radius: 8, x: 0, y: 2)
                        }
                        .frame(height: 82)
                        .onTapGesture {
                            showScheduledJobs.toggle()
                        }
                        HStack {
                            Text("Available Jobs")
                                .frame(height: 40)
                                .font(.cascaded(ofSize: .h16, weight: .medium))
                                .foregroundColor(.white)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color(hex: AppUserInterface.Colors.appButtonBlack))
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.2), radius: 8, x: 0, y: 2)
                        }
                        .onTapGesture {
                            showAvailableJobs.toggle()
                        }
                    }
                }
                .padding(.horizontal, 32)
                .frame(maxHeight: 300, alignment: .topLeading)
                .clipShape(RoundedCorners(topLeft: 20, topRight: 20, bottomLeft: 0, bottomRight: 0))
            }
        }
        .onAppear {
            supabaseClient.fetchScheduledJobs()
        }
        .fullScreenCover(isPresented: $showAvailableJobs, content: {
            AvailableJobsView()
        })
        .fullScreenCover(isPresented: $showScheduledJobs, content: {
            ScheduledJobsView()
        })
    }
}

#Preview {
    HomeView()
}
