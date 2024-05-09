//
//  TermsString.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct TermsAndConditionLabel: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Text("By Signing up, you agree to the ")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
                Text(makeAttributedString(str: "Terms of Service"))
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
                Spacer()
            }
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Text("and ")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
                Text(makeAttributedString(str: "Privacy Policy."))
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
                Spacer()
            }
        }
    }
    
    func makeAttributedString(str: String) -> AttributedString {
        var string = AttributedString(str)
        string.foregroundColor = Color.black
        string.link = URL(string: "")
        return string
    }
}
