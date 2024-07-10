//
//  JobItemCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

struct WorkItemCell: View {
    var image: String
    var text: String
    var value: String
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: image)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.black)
            Text(text)
                .font(.cascaded(ofSize: .h20, weight: .regular))
            Text(value)
                .font(.cascaded(ofSize: .h20, weight: .regular))
            Spacer()
        }
    }
}
