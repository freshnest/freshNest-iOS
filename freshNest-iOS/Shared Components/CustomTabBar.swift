//
//  CustomTabBar.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

// home, earnings, inbox, calendar, account
enum Tab: String, CaseIterable {
    case home
    case earning
    case inbox
    case calendar
    case account
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Spacer()
                    Image(tab.rawValue)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(tab == selectedTab ? .black : .gray)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                                print(selectedTab.rawValue)
                            }
                        }
                        .background(
                            ZStack(alignment: .top) {
                                withAnimation(.easeInOut(duration: 0.3)){
                                    RoundedRectangle(cornerRadius: 2)
                                        .frame(width: tab == selectedTab  ? 30 : 0, height: 4)
                                        .offset(y: -20)
                                }
                            }
                        )
                    Spacer()
                }
            }
            .frame(width: nil, height: 50)
            .background(.white)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.home))
    }
}
