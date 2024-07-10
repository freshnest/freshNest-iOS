//
//  NotificationCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

struct NotificationCell: View {
    var image: String
    var name: String
    var message: String
    var bookingStatus: String
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image("profilePlaceholderImage")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.black.opacity(0.05), lineWidth: 1)
                    )
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.cascaded(ofSize: .h16, weight: .regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Text(message)
                        .font(.cascaded(ofSize: .h18, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Text(bookingStatus)
                        .font(.cascaded(ofSize: .h16, weight: .regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
            }
            Divider()
        }
    }
}
