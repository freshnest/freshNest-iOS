//
//  ScheduledJobsView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct ScheduledJobsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var supabaseClient: SupabaseManager
    @State var isLoading = false
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Spacer()
                    Text("Scheduled Jobs")
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
                    VStack {
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
                            if supabaseClient.scheduledJobsArray.isEmpty {
                                EmptyStateView(message: "You don't have any scheduled jobs currently.", imageText: "📭")
                            } else {
                                ForEach(supabaseClient.scheduledJobsArray, id: \.self) { data in
                                    ScheduledJobCardCell(data: data)
                                        .padding(4)
                                }
                            }
                        }
                    }
                }
            }
            .padding(16)
            .onAppear{
                isLoading = true
                supabaseClient.fetchScheduledJobs()
                isLoading = false
            }
        }
    }
}

#Preview {
    ScheduledJobsView()
}
