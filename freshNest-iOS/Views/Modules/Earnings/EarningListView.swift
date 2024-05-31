//
//  EarningListView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 17/05/24.
//

import SwiftUI

struct EarningListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Spacer()
                Text("Your Earnings")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .accessibility(addTraits: .isHeader)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                Spacer()
                HStack {
                    BackButton()
                    Spacer()
                }
            }
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 120)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: -5, y: -5)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: 5, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .overlay(
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Balance")
                            .font(.cascaded(ofSize: .h16, weight: .medium))
                        Text("$ 1355.97")
                            .font(.cascaded(ofSize: .h42, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(hex: AppUserInterface.Colors.gradientColor1),
                                        Color(hex: AppUserInterface.Colors.gradientColor1),
                                        Color(hex: AppUserInterface.Colors.gradientColor3)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                ))
                        Text("All pending amount will be added once they are verified.")
                            .font(.cascaded(ofSize: .h12, weight: .regular))
                                .foregroundColor(.gray)
                    }
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                )
            
            Text("Recent Earnings")
                .font(.cascaded(ofSize: .h24, weight: .medium))
                .padding(.top, 32)
            
           
            ScrollView(showsIndicators: false) {
                ForEach(earnings, id: \.self) { item in
                    EarningListViewCell(address: item.address, date: item.date, amount: item.amount)
                }
            }
           
        }
        .padding(16)
    }
}

#Preview {
    EarningListView()
//    EarningListViewCell()
}

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
