//
//  FormView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct FormView: View {
    @Binding var email: String
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                RoundedTextField(text: $firstName, placeholderText: "First Name", isSecure: false)
                RoundedTextField(text: $lastName, placeholderText: "Last Name", isSecure: false)
            }
            RoundedTextField(text: $email, placeholderText: "johndoe@example.com", isSecure: false)
            RoundedTextField(text: $password, placeholderText: "password", isSecure: true)
        }
    }
}
