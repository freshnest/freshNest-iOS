//
//  CalendarViewItemCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

struct CalendarViewItemCell: View {
    var amount: String
    var workItems: String
    var address: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(workItems)
                    .font(.cascaded(ofSize: .h18, weight: .medium))
                    .foregroundStyle(.black)
                Spacer()
                Text(amount)
                    .font(.cascaded(ofSize: .h18, weight: .regular))
                    .foregroundStyle(.black)
            }
            Text(address)
                .font(.cascaded(ofSize: .h14, weight: .regular))
                .foregroundStyle(.black)
        }
        .padding(8)
    }
}
