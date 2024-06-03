//
//  VacationModeView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct VacationModeView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Namespace var animation
    @AppStorage("isVacationModeEnabled") var isVacationModeEnabled = false
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 24) {
                HeaderCell(headerTitle: "Vacation Mode")
                VStack(alignment: .leading, spacing: 8) {
                    
                    ToggleRow(text: "Enable Vacation Mode", bool: isVacationModeEnabled, onTap: {
                        isVacationModeEnabled.toggle()
                    })
                    
                    Text(
                        "Activate this option to receive stop receiving recommended available jobs"
                    )
                    .font(.cascaded(ofSize: .h14, weight: .regular))
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            .padding(16)
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    public func ToggleRow(text: String, bool: Bool, smaller: Bool = false, onTap: @escaping () -> Void)
    -> some View {
        HStack(spacing: 12) {
            Text(text)
                .font(.cascaded(ofSize: .h18, weight: .regular))
                .lineLimit(1)
                .foregroundColor(Color.black)
            
            Spacer()
            
            ZStack(alignment: bool ? .trailing : .leading) {
                Capsule()
                    .frame(width: 42, height: 28)
                    .foregroundColor(bool ? .green : .gray.opacity(0.8))
                
                Circle()
                    .foregroundColor(Color.white)
                    .padding(2)
                    .frame(width: 28, height: 28)
            }
            .onTapGesture {
                withAnimation {
                    onTap()
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VacationModeView()
}
