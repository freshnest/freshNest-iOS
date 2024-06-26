//
//  MainView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/05/24.
//

import SwiftUI

struct MainView: View {
    @State private var tabSelected: Tab = .home
    init() {
        UITabBar.appearance().isHidden = false
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabSelected) {
                HomeView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(Tab.home)
                
                EarningsMainView()
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
            CustomTabBar(selectedTab: $tabSelected)
                .frame(height: 70)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    MainView()
    
}


import Foundation

class TabBarManager: ObservableObject {
    @Published var hideTab = false
    @Published var inNavigationLink = false

    func navigationHideTab() {
        inNavigationLink = true
        hideTab = true
    }

    func navigationShowTab() {
        inNavigationLink = false
        hideTab = false
    }

    func scrollHideTab() {
        if !inNavigationLink {
            hideTab = true
        }
    }

    func scrollShowTab() {
        if !inNavigationLink {
            hideTab = false
        }
    }
}
