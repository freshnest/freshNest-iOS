//
//  AddZipCode.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 06/06/24.
//

import SwiftUI

struct AddZipCode: View {
    @State private var zipCode = ""
    var body: some View {
        VStack(alignment: .leading) {
            BackButton()
            VStack(alignment: .leading, spacing: 16) {
                Text("Please add a ZipCode")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor))
                RoundedTextField(text: $zipCode, placeholderText: "XXXXX", isSecure: false)
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
    AddZipCode()
}
