//
//  AvailableJobsView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct AvailableJobsView: View {
    var body: some View {
        VStack {
            ZStack {
                Spacer()
                Text("Available Jobs")
                    .font(.system(size: 28, weight: .bold))
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
                        JobCardCell(data: job)
                            .padding(4)
                    }
                }
            }
        }
        .padding(16)
    }
}

#Preview {
    AvailableJobsView()
}
