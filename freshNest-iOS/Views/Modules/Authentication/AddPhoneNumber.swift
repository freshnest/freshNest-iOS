//
//  AddPhoneNumber.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 06/06/24.
//

import SwiftUI

struct AddPhoneNumber: View {
    @State private var phoneNumber = ""
    var body: some View {
        VStack(alignment: .leading) {
            BackButton()
            VStack(alignment: .leading, spacing: 16) {
                Text("Please add your phone number")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor))
                RoundedTextField(text: $phoneNumber, placeholderText: "(XXX)-XXX-XXXX", isSecure: false)
            }
            .padding(.top, 40)
            Spacer()
            VStack(spacing: 16) {
                RoundedButton(title: "Save", action: {
                    
                }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
//    AddPhoneNumber()
    AddLocationView()
}
