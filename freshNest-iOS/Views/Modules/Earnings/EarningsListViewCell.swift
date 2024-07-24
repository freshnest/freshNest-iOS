//
//  EarningsListViewCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 24/07/24.
//

import SwiftUI

struct EarningListViewCell : View {
    var address: String?
    var date: String?
    var amount: String?
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .overlay {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(address ?? "Fenway Street, Massachussets")
                                .font(.cascaded(ofSize: .h18, weight: .medium))
                            
                            Text(date ?? "26th May 2024")
                                .font(.cascaded(ofSize: .h16, weight: .medium))
                                .foregroundStyle(.black.opacity(0.6))
                        }
                        Spacer()
                        Text(amount ?? "$125.00")
                            .font(.cascaded(ofSize: .h28, weight: .medium))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
        }
    }
}
