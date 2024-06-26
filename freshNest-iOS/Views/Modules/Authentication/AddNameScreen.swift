//
//  AddNameScreen.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 12/06/24.
//

import SwiftUI

struct AddNameScreen: View {
    @State private var firstName = ""
    @State private var lastName = ""
    var body: some View {
        VStack(alignment: .leading) {
            BackButton()
            VStack(alignment: .leading, spacing: 16) {
                Text("Please add Your name")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor))
                HStack {
                    RoundedTextField(text: $firstName, placeholderText: "First Name", isSecure: false)
                    Spacer()
                    RoundedTextField(text: $lastName, placeholderText: "Last Name", isSecure: false)
                }
            }
            .padding(.top, 40)
            Spacer()
            VStack(spacing: 16) {
                RoundedButton(title: "Save", action: {
                    //action here.
                }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AddNameScreen()
}
