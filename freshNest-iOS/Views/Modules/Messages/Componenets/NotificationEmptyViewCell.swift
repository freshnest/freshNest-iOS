//
//  NotificationEmptyView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

struct NotificationEmptyViewCell : View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "bell")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundStyle(.black)
            
            Text("No Notifications yet")
                .font(.cascaded(ofSize: .h16, weight: .medium))
            
            Text("You've got a blank slate (for now). We'll let you know when the update arrives")
                .font(.cascaded(ofSize: .h16, weight: .regular))
                .multilineTextAlignment(.center)
        }
    }
}
