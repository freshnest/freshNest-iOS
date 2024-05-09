//
//  RoundedButton.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct RoundedButton: View {
    let title: String
    let action: () -> Void
    let color: Color
    let textColor: Color?
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(textColor)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(color)
                .cornerRadius(30)
        }
        .onTapGesture {
            action()
        }
    }
}
