//
//  CustomChatTextField.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 28/06/24.
//

import SwiftUI

struct CustomChatTextField: View {
    @Binding var text: String
    var actionForSend: () -> Void
    @State private var isEmojiTextFieldVisible = false
    var body: some View {
        HStack {
            TextField("Type your message", text: $text)
                .padding(.vertical, 16)
                .padding(.trailing, 50)
                .padding(.leading, 16)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 2)
                .overlay(
                    HStack {
                        Spacer()
                        Button(action: {
                            actionForSend()
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.black)
                                .padding(.trailing, 8)
                        }
                    }
                )
        }
    }
}

#Preview {
    CustomChatTextField(text: .constant("jeje"), actionForSend: {})
}
