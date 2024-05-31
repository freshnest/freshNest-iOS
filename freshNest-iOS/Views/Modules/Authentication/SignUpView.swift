//
//  SignUpView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct SignUpView: View {
    var isBackButtonHidden = false
    @State private var email = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var password = ""
    @State private var showLoginScreen = false
    var body: some View {
        VStack(alignment: .leading) {
            if !isBackButtonHidden {
                BackButton()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Let’s Get Started!")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor))
                Text("Fill the form to continue.")
                    .font(.cascaded(ofSize: .h12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
            }
            .padding(.top, 40)
            FormView()
                .padding(.top, 16)
//            Spacer()
            TermsAndConditionLabel()
                .padding(.top, 24)
            Spacer()
            VStack(spacing: 16) {
                RoundedButton(title: "Sign Up", action: {
                    // signup action
                }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
                RoundedButton(title: "Existing User?", action: {
                    // login action
                    showLoginScreen.toggle()
                }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
            }
            .padding(.horizontal, 16)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .fullScreenCover(isPresented: $showLoginScreen, content: {
            LoginView()
        })
    }
}

#Preview {
    SignUpView()
}
