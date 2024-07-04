//
//  TabBarManager.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 28/06/24.
//

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
