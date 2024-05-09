//
//  AccountRowView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct SettingsRowView: View {
    //    var systemImage: String
    var title: String
    //    var color: String
    var optionalText: String?
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        HStack(spacing: 12) {
            //            Image(systemName: systemImage)
            //                .font(.system(.body, design: .rounded))
            //                .foregroundColor(.white)
            //                .frame(
            //                    width: dynamicTypeSize > .xLarge ? 40 : 30, height: dynamicTypeSize > .xLarge ? 40 : 30,
            //                    alignment: .center
            //                )
            //                .background(Color(hex: color), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
            
            Text(LocalizedStringKey(title))
                .font(.system(.body, design: .rounded).weight(.medium))
                .lineLimit(1)
                .foregroundColor(Color.black.opacity(0.9))
            
            Spacer()
            
            if optionalText != nil {
                Text(optionalText!)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.gray.opacity(0.6))
                    .layoutPriority(1)
                    .padding(.trailing, -8)
            }
            
            Image(systemName: "chevron.forward")
                .font(.system(.subheadline, design: .rounded))
            //                .font(.system(size: 15))
                .foregroundColor(.gray.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
}

