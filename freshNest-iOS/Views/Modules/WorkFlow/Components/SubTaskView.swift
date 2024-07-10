//
//  SubTaskView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

struct SubtaskView: View {
    let subtask: String?
    @Binding var isChecked: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(isChecked ? .green : .black)
                .scaleEffect(isChecked ? 0.9 : 1)
                .padding(.trailing, 8)
            
            Text(subtask ?? "")
                .font(.cascaded(ofSize: .h14, weight: .regular))
                .strikethrough(isChecked, color: .black)
            
            Spacer()
        }
    }
}
