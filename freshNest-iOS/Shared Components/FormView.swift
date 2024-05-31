//
//  FormView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct FormView: View {
    @State private var email = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("First Name", text: $firstName)
                .font(.cascaded(ofSize: .h16, weight: .regular))
                .frame(height: 44)
                .background(.clear)
                .cornerRadius(5.0)
            Divider()
            TextField("Last Name", text: $lastName)
                .font(.cascaded(ofSize: .h16, weight: .regular))
                .frame(height: 44)
                .background(.clear)
                .cornerRadius(5.0)
            Divider()
            TextField("Email", text: $email)
                .font(.cascaded(ofSize: .h16, weight: .regular))
                .frame(height: 44)
                .background(.clear)
                .cornerRadius(5.0)
            Divider()
            SecureField("Password", text: $password)
                .font(.cascaded(ofSize: .h16, weight: .regular))
                .frame(height: 44)
                .background(.clear)
                .cornerRadius(5.0)
            Divider()
        }
    }
}
