//
//  ReviewsView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct ReviewsView: View {
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Spacer()
                Text("Reviews")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .accessibility(addTraits: .isHeader)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                Spacer()
                HStack {
                    BackButton()
                    Spacer()
                }
            }
        }
        .padding(16)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ReviewsView()
}
