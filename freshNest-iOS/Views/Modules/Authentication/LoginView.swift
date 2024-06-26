//
//  LoginView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI
import Supabase

struct LoginView: View {
    @AppStorage("isAuthenticated") var isAuthenticated = false
    @EnvironmentObject private var viewModel: SupabaseManager
    @State private var email = ""
    @State private var password = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var showHomeScreen = false
    @State private var showLocationScreen = false
    @State var longitude = 0.0
    @State var latitude = 0.0
    var body: some View {
        VStack(alignment: .leading) {
            BackButton()
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome back, to FreshNest")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor))
                Text("Please enter your details for logging into your account.")
                    .font(.cascaded(ofSize: .h12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
            }
            .padding(.top, 40)
            VStack(spacing: 8) {
                RoundedTextField(text: $email, placeholderText: "johndoe@example.com", isSecure: false)
                RoundedTextField(text: $password, placeholderText: "password", isSecure: true)
            }
                .padding(.top, 24)
            Spacer()
            VStack(spacing: 16) {
                RoundedButton(title: "Sign In", action: {
                    // Sign In logic
                    Task {
                        print("Email: \(email), Password: \(password)")
                        let validationResult = validateInput(email: email, password: password)
                        if validationResult {
                            await viewModel.signIn(email: email, password: password)
                            await viewModel.isUserAuthenticated()
                            if viewModel.isAuthenticated {
                                await checkLocationAccess()
                                if longitude == 0.0 && latitude == 0.0 {
                                    showLocationScreen.toggle()
                                } else {
                                    isAuthenticated = true
                                    showHomeScreen.toggle()
                                    print("\(longitude), \(latitude)")
                                }
                            }
                        } else {
                            showAlert.toggle()
                        }
                    }
                }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .fullScreenCover(isPresented: $showHomeScreen, content: {
            MainView()
        })
        .fullScreenCover(isPresented: $showLocationScreen) {
            AddLocationView()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Validation Result"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    func checkLocationAccess() async {
        do {
            let currentUser = try await viewModel.supabase.auth.session.user
            
            let clearnerProfile: CleanersModel = try await viewModel.supabase.database
                .from("cleaners")
                .select()
                .eq("id", value: currentUser.id)
                .single()
                .execute()
                .value
            
            longitude = clearnerProfile.longitude ?? 0.0
            latitude = clearnerProfile.latitude ?? 0.0
        } catch {
            debugPrint(error)
        }
    }
    
    func validateInput(email: String, password: String) -> Bool {
        if !isValidEmail(email) {
            alertMessage = "Invalid email address."
            return false
        }
        
        if password.count < 6 {
            alertMessage = "Password must be at least 6 characters long."
            return false
        }
        
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    LoginView()
}
