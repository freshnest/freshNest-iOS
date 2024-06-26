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
                    .font(.cascaded(ofSize: .h16, weight: .regular))
            } else {
                TextField(placeholderText, text: $text)
                    .font(.cascaded(ofSize: .h16, weight: .regular))
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
        .overlay {
            RoundedRectangle(cornerRadius: 10).stroke(.black.opacity(0.1), lineWidth: 1)
                .background(Color.clear)
                .cornerRadius(10)
        }
        
    }
}
