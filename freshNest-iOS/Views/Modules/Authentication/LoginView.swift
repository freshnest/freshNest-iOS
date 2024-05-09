//
//  LoginView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showHomeScreen = false
    var body: some View {
        VStack(alignment: .leading) {
            BackButton()
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome to FreshNest")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor))
                Text("Please enter your details for logging into your account.")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
            }
            .padding(.top, 40)
            VStack(spacing: 16) {
                RoundedTextField(text: $email, placeholderText: "johndoe@example.com", isSecure: false)
                RoundedTextField(text: $password, placeholderText: "password", isSecure: true)
            }
                .padding(.top, 24)
            Spacer()
            VStack(spacing: 16) {
                RoundedButton(title: "Sign In", action: {
                    // Sign In logic
                    showHomeScreen.toggle()
                }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .fullScreenCover(isPresented: $showHomeScreen, content: {
            HomeView()
        })
    }
}

#Preview {
    LoginView()
}
