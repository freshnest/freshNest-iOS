//
//  RoundedTextField.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct RoundedTextField: View {
    @Binding var text: String
    var placeholderText: String
    
    @State var isSecure: Bool
    @State private var showPassword: Bool = false
    
    var body: some View {
        HStack {
            if isSecure && !showPassword {
                SecureField(placeholderText, text: $text)
            } else {
                TextField(placeholderText, text: $text)
            }
            
            Button(action: {
                showPassword.toggle()
            }) {
                Image(systemName: !showPassword ? "eye.slash" : "eye")
                    .opacity(isSecure ? 1 : 0)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
}
