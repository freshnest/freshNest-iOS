//
//  BackgroundCheckView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct BackgroundCheckView: View {
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Spacer()
                Text("Background Check")
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
    BackgroundCheckView()
}
