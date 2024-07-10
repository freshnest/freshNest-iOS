//
//  NotificationItemCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

struct NotificationItemCell : View {
//    var image: String
//    var date: String
//    var message: String
    var body: some View {
        HStack {
            Image(systemName: "calendar.badge.checkmark")
                .scaledToFit()
                .foregroundColor(.white)
                .background(
                    Circle()
                        .fill(Color.purple)
                        .frame(width: 60, height: 60)
                )
                .padding(.trailing, 24)
            VStack(alignment: .leading) {
                Text("You have 5 upcoming cleaning bookings scheduled!")
                    .font(.cascaded(ofSize: .h18, weight: .medium))
                Text("May 12, 2024")
                    .font(.cascaded(ofSize: .h14, weight: .regular))
            }
        }
    }
}

