//
//  MainView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/05/24.
//

import SwiftUI

struct MainView: View {
    @State private var tabSelected: Tab = .home
    @EnvironmentObject var tabBarManager: TabBarManager
    init() {
        UITabBar.appearance().isHidden = false
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabSelected) {
                HomeView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(Tab.home)
                
                EarningListView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(Tab.earning)
                
                InboxMainView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(Tab.inbox)
                
                CalendarView(selectedDate: Date())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(Tab.calendar)
                
                AccountsView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(Tab.account)
            }
            .offset(y: tabBarManager.hideTab ? 70 : 0)
            CustomTabBar(selectedTab: $tabSelected)
                .frame(height: 70)
                .offset(y: tabBarManager.hideTab ? 70 : 0)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    MainView()
    
}
