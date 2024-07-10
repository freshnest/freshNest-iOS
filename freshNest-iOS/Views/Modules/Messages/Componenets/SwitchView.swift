//
//  SwitchView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

struct SwitchView: View {
    @Binding var selectedTab: InboxMainView.Switch
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Button(action: {
                    self.selectedTab = .inbox
                }) {
                    Text("Messages")
                        .padding(.vertical, 10)
                        .background(.clear)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .background(
                    ZStack(alignment: .top) {
                        withAnimation(.easeInOut(duration: 0.3)){
                            RoundedRectangle(cornerRadius: 2)
                                .frame(width: self.selectedTab == .inbox  ? 80 : 0, height: 4)
                                .offset(y: 20)
                        }
                    }
                )
                Button(action: {
                    self.selectedTab = .notification
                }) {
                    Text("Notifications")
                        .padding(.vertical, 10)
                        .background(.clear)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .background(
                    ZStack(alignment: .top) {
                        withAnimation(.easeInOut(duration: 0.3)){
                            RoundedRectangle(cornerRadius: 2)
                                .frame(width: self.selectedTab == .notification  ? 100 : 0, height: 4)
                                .offset(y: 20)
                        }
                    }
                )
            }
        }
    }
}
