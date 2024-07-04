//
//  TabBarVisibilityModifier.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 28/06/24.
//

import Foundation
import SwiftUI

struct TabBarVisibilityModifier: ViewModifier {
    @EnvironmentObject var tabBarManager: TabBarManager
    func body(content: Content) -> some View {
        content
            .onAppear {
                withAnimation(.easeOut.speed(2)) {
                    tabBarManager.navigationHideTab()
                }
            }
            .onDisappear {
                withAnimation(.easeOut.speed(2)) {
                    tabBarManager.navigationShowTab()
                }
            }
    }
}

extension View {
    func manageTabBarVisibility() -> some View {
        self.modifier(TabBarVisibilityModifier())
    }
}
