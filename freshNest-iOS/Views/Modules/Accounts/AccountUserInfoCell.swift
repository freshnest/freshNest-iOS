//
//  AccountUserInfoCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 31/05/24.
//

import SwiftUI

struct AccountUserInfoCell: View {
    var action: () -> Void?
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack {
                Image("profile")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .overlay {
                        Image(systemName: "square.and.pencil")
                            .frame(width: 12, height: 12)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.white)
                            )
                            .offset(x: 20, y: 20)
                    }
                    .onTapGesture {
                        print("Profile Picture Edit Button clicked!")
                        action()
                    }
            }
            VStack(alignment: .leading, spacing: 0) {
                Text("Cheyenne Newstead")
                    .font(.cascaded(ofSize: .h24, weight: .bold))
                Spacer()
                Text("★  4.56")
                    .font(.cascaded(ofSize: .h12, weight: .regular))
                    .padding(6)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.black.opacity(0.09))
                    )
            }
            Spacer()
        }
        .frame(maxHeight: 60)
    }
}

#Preview {
    AccountUserInfoCell(action: {})
}
