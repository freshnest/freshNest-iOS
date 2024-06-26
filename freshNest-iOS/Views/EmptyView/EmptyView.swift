//
//  EmptyView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 24/06/24.
//

import SwiftUI

struct EmptyStateView: View {
    var message: String
    var imageText: String
    var body: some View {
        VStack(alignment: .center) {
            Text(imageText)
                .font(.system(size: 72))
            Text(message)
                .font(.cascaded(ofSize: .h24, weight: .regular))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    EmptyStateView(message: "You don't have any scheduled jobs currently.", imageText: "🗓️")
}
