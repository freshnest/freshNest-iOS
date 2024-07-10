//
//  CircularButton.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

struct CircularButton: View {
    var image: String
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
                    .padding(8)
                Text(text)
                    .font(.cascaded(ofSize: .h12, weight: .regular))
                    .foregroundStyle(.black)
            }
            .frame(height: 80)
        }
        .shadow(color: .black.opacity(0.2), radius: 10, x: -5, y: -5)
    }
}
