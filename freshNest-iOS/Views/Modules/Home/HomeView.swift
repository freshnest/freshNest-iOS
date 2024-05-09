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
            MapView()
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hello, John")
                        .font(.system(size: 32, weight: .bold))
                    Text("You have 4 jobs scheduled!")
                        .font(.system(size: 18, weight: .regular))
                }
                .padding(.vertical, 20)
                VStack(spacing: 20) {
                    HStack {
                        Text("Scheduled Jobs")
                            .frame(height: 40)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color(hex: AppUserInterface.Colors.appButtonGrey))
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
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color(hex: AppUserInterface.Colors.appButtonGrey))
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.2), radius: 8, x: 0, y: 2)
                    }
                    .onTapGesture {
                        showAvailableJobs.toggle()
                    }
                }
            }
            .frame(maxHeight: 400, alignment: .topLeading)
            .padding(.horizontal, 32)
            .padding(.bottom, 16)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
                    .clipShape(RoundedCorners(topLeft: 20, topRight: 20, bottomLeft: 0, bottomRight: 0))
            )
            .offset(y: 40)
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
