//
//  CardDetailsEntryBottomSheet.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct CardDetailsEntryBottomSheet: View {
    @State private var cardNumber = ""
    @State private var expiry = ""
    @State private var securityCode = ""
    @State private var name = ""
    @State private var isNumberType = true
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Spacer()
                Text("Add New Card")
                    .font(.cascaded(ofSize: .h20, weight: .medium))
                Spacer()
            }
            .padding(.vertical, 24)
            VStack {
                Text("Start typing to add your credit card details.Everything will upadate according to your data.")
                    .font(.cascaded(ofSize: .h14, weight: .regular))
                    .foregroundStyle(Color.black.opacity(0.5))
                    .padding(.horizontal, 16)
                if !cardNumber.isEmpty {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        CardView(cardNumber: cardNumber, accountHolderName: name, expiry: expiry)
                            .padding(.vertical, 16)
                    }
                }
                FloatingPlaceholderTextField(text: $cardNumber, placeholder: "1234 1234 1234 1234", fieldHeading: "Card Number (16 digits)", characterLimit: 16, keyboardType: .numberPad)
                
                HStack {
                    FloatingPlaceholderTextField(text: $expiry, placeholder: "MM/YY", fieldHeading: "Expiry Date", characterLimit: 5, keyboardType:.numbersAndPunctuation)
                    FloatingPlaceholderTextField(text: $securityCode, placeholder: "123", fieldHeading: "CVV", characterLimit: 3, keyboardType: .numberPad)
                }
                
                FloatingPlaceholderTextField(text: $name, placeholder: "John Doe", fieldHeading: "Name", characterLimit: 30, keyboardType: .alphabet)
            }
            Spacer()
            RoundedButton(title: "Add Payment Details", action: {}, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
                .padding(.horizontal, 32)
                .padding(.top, 24)
        }
        .frame(alignment: .bottom)
    }
}


#Preview {
    CardDetailsEntryBottomSheet()
}
