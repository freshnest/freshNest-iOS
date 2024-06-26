//
//  TermsString.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct TermsAndConditionLabel: View {
    @Binding var isTermsChecked: Bool
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                // checkBox
                Button(action: {
                    isTermsChecked.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.black)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(isTermsChecked ? Color.black : Color.clear)
                            )
                        if isTermsChecked {
                            Image(systemName: "checkmark")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                        }
                    }
                    .padding(.trailing, 16)
                }
                Text("You agree to the ")
                    .multilineTextAlignment(.center)
                    .font(.cascaded(ofSize: .h12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
                Text(makeAttributedString(str: "Terms of Service"))
                    .font(.cascaded(ofSize: .h12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
                Text("and ")
                    .multilineTextAlignment(.center)
                    .font(.cascaded(ofSize: .h12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
                Text(makeAttributedString(str: "Privacy Policy."))
                    .font(.cascaded(ofSize: .h12, weight: .regular))
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

//#Preview {
//    TermsAndConditionLabel()
//}
