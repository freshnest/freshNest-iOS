//
//  freshNest_iOSApp.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 06/05/24.
//

import SwiftUI
import StripeCore

@main
struct freshNest_iOSApp: App {
    @StateObject var authVM = SupabaseManager()
    @StateObject var tabBarManager = TabBarManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
                .environmentObject(tabBarManager)
                .onOpenURL { incomingURL in
                    let stripeHandled = StripeAPI.handleURLCallback(with: incomingURL)
                    if (!stripeHandled) {
                        // This was not a Stripe url – handle the URL normally as you would
                    }
                }
        }
    }
}
