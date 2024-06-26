//
//  AccountUserInfoCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 31/05/24.
//

import SwiftUI

struct AccountUserInfoCell: View {
    var action: () -> Void?
    @EnvironmentObject var supabaseClient: SupabaseManager
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack {
                Image("profilePlaceholderImage")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.black.opacity(0.05), lineWidth: 1)
                    )
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
                Text("\(supabaseClient.userProfile?.firstName ?? "") \(supabaseClient.userProfile?.lastName ?? "")")
                    .font(.cascaded(ofSize: .h24, weight: .bold))
                Spacer()
                Text("★ \(String(format: "%.2f", supabaseClient.userProfile?.averageRating ?? 0.0))")
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
