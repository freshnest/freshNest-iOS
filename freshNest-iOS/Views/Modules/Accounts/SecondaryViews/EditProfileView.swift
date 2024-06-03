//
//  EditProfileView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                ZStack(alignment: .center) {
                    HStack {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Image(systemName: "arrow.left")
                                .font(.system(.title2, design: .rounded).weight(.semibold))
                                .foregroundColor(Color.black)
                        }
                        Spacer()
                    }
                    Text("Profile")
                        .font(.cascaded(ofSize: .h28, weight: .bold))
                        .accessibility(addTraits: .isHeader)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                }
                SettingsRowView(systemImage: "", title: "Name", optionalText: "Alex Cheyenne")
                SettingsRowView(systemImage: "", title: "Phone", optionalText: "+1 (695) 21315")
                SettingsRowView(systemImage: "", title: "Email", optionalText: "alex.chey87@gmail.com")
                
                Spacer()
            }
            .padding(16)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EditProfileView()
}

