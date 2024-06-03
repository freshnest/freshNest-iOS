//
//  EditJobRadiusView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct EditJobRadiusView: View {
    @State private var selectedRadius: Int = 0
    @State private var initialRadius: Int = 0
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 24) {
            HeaderCell(headerTitle: "Job Radius")
            
            HStack(spacing: 12) {
                Text("Select Radius")
                    .font(.cascaded(ofSize: .h18, weight: .regular))
                    .lineLimit(1)
                    .foregroundColor(Color.black.opacity(0.9))
                
                Spacer()
                
                Picker("Select Radius", selection: $selectedRadius) {
                    ForEach(5..<26) { radius in
                        Text("\(radius) miles").tag(radius)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
            }
            .frame(height: 20)
            .frame(maxWidth: .infinity)
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            
            Spacer()
            
            if selectedRadius != initialRadius {
                RoundedButton(title: "Save", action: {
                    initialRadius = selectedRadius
                    presentationMode.wrappedValue.dismiss()
                }, color: .black, textColor: .white)
            }
        }
        .padding(16)
        .navigationBarBackButtonHidden()
        .onAppear {
            initialRadius = selectedRadius
        }
    }
}


#Preview {
    EditJobRadiusView()
}
