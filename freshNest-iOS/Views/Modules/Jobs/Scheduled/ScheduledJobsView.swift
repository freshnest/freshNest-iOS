//
//  ScheduledJobsView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct ScheduledJobsView: View {
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
                        BackButton()
                        Spacer()
                    }
                }
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(scheduledJobs, id: \.self) { job in
                            NavigationLink(destination: WorkFlowView()) {
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
    ScheduledJobsView()
}
