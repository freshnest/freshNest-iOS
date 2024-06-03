//
//  HeaderCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct HeaderCell: View {
    var headerTitle: String
    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                BackButton()
                Spacer()
            }
            Text(headerTitle)
                .font(.cascaded(ofSize: .h28, weight: .bold))
                .accessibility(addTraits: .isHeader)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        }
    }
}

#Preview {
    HeaderCell(headerTitle: "Test")
}
