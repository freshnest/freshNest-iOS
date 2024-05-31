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

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                MapView()
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hello there, John")
                            .font(.cascaded(ofSize: .h32, weight: .bold))
                        Text("You have 4 jobs scheduled!")
                            .font(.cascaded(ofSize: .h24, weight: .regular))
                    }
                    .padding(.vertical, 20)
                    VStack(spacing: 20) {
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
                .frame(maxHeight: 300, alignment: .topLeading)
                .padding(.horizontal, 32)
                .padding(.bottom, 16)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.white)
                        .clipShape(RoundedCorners(topLeft: 20, topRight: 20, bottomLeft: 0, bottomRight: 0))
                )
//                .offset(y: 40)
            }
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
