//
//  TabTestView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/05/24.
//

import SwiftUI

struct TabTestView: View {
    @State private var tabSelected: Tab = .account
    
    init() {
        UITabBar.appearance().isHidden = false
    }
    var body: some View {
        VStack {
            TabView(selection: $tabSelected) {
                HomeView()
                    .tag(Tab.home)
                
                EarningsMainView()
                    .tag(Tab.earning)
                
                HomeView()
                    .tag(Tab.inbox)
                
                HomeView()
                    .tag(Tab.calendar)
                
                AccountsView()
                    .tag(Tab.account)
            }
            .overlay {
                CustomTabBar(selectedTab: $tabSelected)
            }
        }
    }
}

#Preview {
    TabTestView()
}
