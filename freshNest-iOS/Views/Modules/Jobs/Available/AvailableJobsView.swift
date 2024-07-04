//
//  AvailableJobsView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct AvailableJobsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var supabaseClient: SupabaseManager
    @State var isLoading = false
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Spacer()
                    Text("Available Jobs")
                        .font(.cascaded(ofSize: .h28, weight: .bold))
                        .accessibility(addTraits: .isHeader)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    Spacer()
                    HStack {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Image(systemName: "arrow.left")
                                .font(.system(.title2, design: .rounded).weight(.semibold))
                                .foregroundColor(Color.black)
                        }
                        Spacer()
                    }
                }
                .padding(.bottom, 16)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        if isLoading {
                            ZStack {
                                VStack {
                                    Spacer()
                                    GrowingArcIndicatorView(color: Color(hex: AppUserInterface.Colors.gradientColor1), lineWidth: 2)
                                        .frame(width: 100)
                                    Spacer()
                                }
                            }
                        } else {
                            if supabaseClient.availableJobsArray.isEmpty {
                                EmptyStateView(message: "You don't have any available jobs currently.", imageText: "📭")
                            } else {
                                ForEach(supabaseClient.availableJobsArray, id: \.self) { data in
                                    AvailableJobCardCell(data: data)
                                        .padding(4)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear{
                fetchJobs()
            }
            .padding(16)
        }
    }
    private func fetchJobs() {
        isLoading = true
        supabaseClient.fetchAvailableJobs { success in
            DispatchQueue.main.async {
                isLoading = false
            }
        }
    }
}

#Preview {
    AvailableJobsView()
}

// let currentUser = try await supabaseClient.supabase.auth.session.user
// try await supabaseClient.supabase.rpc("accept_job", params: ["id": currentUser.id.uuidString]).execute()
