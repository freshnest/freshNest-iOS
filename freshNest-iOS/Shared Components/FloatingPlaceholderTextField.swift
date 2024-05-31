//
//  FloatingPlaceholderTextField.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct FloatingPlaceholderTextField: View {
    @Binding var text: String
    var placeholder: String
    var fieldHeading: String
    @State private var isEditing = false
    var characterLimit: Int
    var keyboardType: UIKeyboardType

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(fieldHeading)
                .font(.cascaded(ofSize: .h10, weight: .regular))
                .foregroundStyle(.black.opacity(0.5))
                .padding(.horizontal, 32)
            VStack(alignment: .leading) {
                TextField(placeholder, text: $text)
                    .font(.cascaded(ofSize: .h16, weight: .medium))
                    .keyboardType(keyboardType)
                    .onChange(of: text) { newValue in
                        if newValue.count > characterLimit {
                            text = String(newValue.prefix(characterLimit))
                        }
                    }
            }
            .padding()
            .padding(.horizontal)
            .onTapGesture {
                withAnimation {
                    self.isEditing = true
                }
            }
            .animation(.default, value: isEditing)
            Divider()
                .padding(.horizontal, 32)
        }
        .padding(.vertical, 4)
        .animation(.default, value: isEditing)
        .onAppear {
            self.isEditing = false
        }
    }
}
