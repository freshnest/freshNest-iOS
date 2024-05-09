//
//  CardView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct CardView: View {
    var cardNumber: String
    var securityCode: String?
    var accountHolderName: String
    var expiry: String
    var isStatic: Bool = false
    @State private var showMaskedNumber = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image("masterCard")
                        .resizable()
                        .frame(width: 50, height: 30)
                    Spacer()
                    if isStatic {
                        Button(action: {
                            showMaskedNumber.toggle()
                        }){
                            Image(systemName: !showMaskedNumber ? "eye.slash" : "eye")
                                .foregroundColor(.black)
                        }
                    }
                }
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    if !isStatic {
                        Text(cardNumber.formatCardNumber()).textCase(.uppercase)
                            .font(.system(size: 24, weight: .bold))
                    } else {
                        Text(!showMaskedNumber ? cardNumber.maskCardNumber() : cardNumber.formatCardNumber()).textCase(.uppercase)
                            .font(.system(size: 24, weight: .bold))
                    }
                }
                Spacer()
                HStack {
                    Text(accountHolderName)
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                    Text(expiry)
                        .font(.system(size: 12, weight: .regular))
                }
            }
            .padding(16)
        }
        .frame(width: 315, height: 200)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
                    .foregroundColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .background(
                                LinearGradient(colors: [
                                    Color(hex: AppUserInterface.Colors.gradientColor1),
                                    Color(hex: AppUserInterface.Colors.gradientColor2),
                                    Color(hex: AppUserInterface.Colors.gradientColor3)], startPoint: .top, endPoint: .bottom)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .opacity(0.5)
                            )
                            .foregroundColor(.clear)
                    )
            }
        )
    }
}
