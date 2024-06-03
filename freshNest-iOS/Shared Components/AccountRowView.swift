//
//  AccountRowView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct SettingsRowView: View {
    var systemImage: String
    var title: String
    var action: () -> Void = {}
    var optionalText: String?
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        HStack(spacing: 12) {
            Text(LocalizedStringKey(title))
                .font(.cascaded(ofSize: .h18, weight: .regular))
                .lineLimit(1)
                .foregroundColor(Color.black.opacity(0.9))
            
            Spacer()
            
            if optionalText != nil {
                Text(optionalText!)
                    .font(.cascaded(ofSize: .h16, weight: .regular))
                    .foregroundColor(.gray.opacity(0.6))
                    .layoutPriority(1)
                    .padding(.trailing, -8)
            }
            
            Image(systemName: "chevron.forward")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.gray.opacity(0.6))
        }
        .frame(height: 20)
        .frame(maxWidth: .infinity)
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        .onTapGesture {
            action()
        }
    }
}

