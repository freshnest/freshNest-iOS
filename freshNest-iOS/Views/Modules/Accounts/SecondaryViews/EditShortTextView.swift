//
//  EditShortTextView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 19/06/24.
//

import SwiftUI

struct EditShortTextView: View {
    @Environment(\.presentationMode) var presentationMode
    var titleText: String
    var placeholderText: String
    var secondplaceholderText: String = "Last Name"
    var ctaTitle: String
    var secondInput: Bool = false
    var action: () -> Void = {}
    @Binding var inputText: String
    @Binding var secondInputText: String
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                HeaderCell(headerTitle: titleText)
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.black.opacity(0.1), lineWidth: 1)
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(Color.clear)
                    )
                    .overlay(
                        TextField(placeholderText, text: $inputText)
                            .font(.cascaded(ofSize: .h18, weight: .regular))
                            .padding(.horizontal, 8)
                            .foregroundColor(.black)
                            .background(Color.clear)
                            .cornerRadius(16)
                    )
                    .padding(.top, 24)
                
                if secondInput {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.black.opacity(0.1), lineWidth: 1)
                        .frame(height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(Color.clear)
                        )
                        .overlay(
                            TextField(secondplaceholderText, text: $secondInputText)
                                .font(.cascaded(ofSize: .h18, weight: .regular))
                                .padding(.horizontal, 8)
                                .foregroundColor(.black)
                                .background(Color.clear)
                                .cornerRadius(16)
                        )
                        .padding(.top, 16)
                }
                
                Spacer()
                
                RoundedButton(title: ctaTitle,
                              action: {
                    action()
                    presentationMode.wrappedValue.dismiss()
                },
                              color: .black, textColor: .white)
            }
            .padding(16)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EditShortTextView(titleText: "Edit Work", placeholderText: "Workplace", ctaTitle: "Save", secondInput: true, inputText: .constant("Apple"), secondInputText: .constant(""))
}
