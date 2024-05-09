//
//  BackButton.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Image(systemName: "arrow.left")
            .font(.system(.title2, design: .rounded).weight(.semibold))
            .foregroundColor(Color.black)
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }
}
