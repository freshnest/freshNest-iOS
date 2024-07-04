//
//  freshNest_iOSApp.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 06/05/24.
//

import SwiftUI

@main
struct freshNest_iOSApp: App {
    @StateObject var authVM = SupabaseManager()
    @StateObject var tabBarManager = TabBarManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
                .environmentObject(tabBarManager)
        }
    }
}
