//
//  AvailableJobsView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct AvailableJobsView: View {
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
                        BackButton()
                        Spacer()
                    }
                }
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(availableJobs, id: \.self) { job in
                            NavigationLink(destination: JobInfoView(data: job)) {
                                JobCardCell(data: job)
                                    .padding(4)
                            }
                        }
                    }
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    AvailableJobsView()
}
