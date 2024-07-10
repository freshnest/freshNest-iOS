//
//  SignUpView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct SignUpView: View {
    @AppStorage("isAuthenticated") var isAuthenticated = false
    @EnvironmentObject private var viewModel: SupabaseManager
    var isBackButtonHidden = false
    @State var email = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var password = ""
    @State private var showLoginScreen = false
    @State private var isTermsChecked = false
    @State private var showLocationScreen = false
    @State private var showMainScreen = false
    @State private var alertItem: AlertItem?
    @State var longitude = 0.0
    @State var latitude = 0.0
    
    var body: some View {
        VStack(alignment: .leading) {
            if !isBackButtonHidden {
                BackButton()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Let's Get Started!")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor))
                Text("Fill the form to continue.")
                    .font(.cascaded(ofSize: .h12, weight: .regular))
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appTitleColor).opacity(0.6))
            }
            .padding(.top, 40)
            FormView(email: $email, firstName: $firstName, lastName: $lastName, password: $password)
                .padding(.top, 16)
            TermsAndConditionLabel(isTermsChecked: $isTermsChecked)
                .padding(.top, 24)
            Spacer()
            VStack(spacing: 16) {
                RoundedButton(title: "Sign Up", action: {
                    Task {
                        print("Email: \(email), Password: \(password)")
                        if validateInput(email: email, firstName: firstName, lastName: lastName, password: password) {
                            await signUp()
                        }
                    }
                }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
                
                RoundedButton(title: "Existing User?", action: {
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
        .fullScreenCover(isPresented: $showLocationScreen) {
            AddLocationView()
        }
        .fullScreenCover(isPresented: $showMainScreen) {
            MainView()
        }
        .alert(item: $alertItem) { item in
            Alert(
                title: Text(item.title),
                message: Text(item.message),
                dismissButton: .default(Text(item.buttonTitle)) {
                    item.action?()
                }
            )
        }
    }
    
    func signUp() async {
        do {
            try await viewModel.signUp(email: email, password: password, firstName: firstName, lastName: lastName)
            await viewModel.isUserAuthenticated()
            if viewModel.isAuthenticated {
                await fetchProfileWithRetry()
            } else {
                alertItem = AlertItem(title: "Sign Up Failed", message: "Unable to create account. Please check credentials and try again.")
            }
        } catch {
            alertItem = AlertItem(title: "Error", message: "An error occurred during sign up: \(error.localizedDescription)")
        }
    }

    func fetchProfileWithRetry(retries: Int = 3) async {
        do {
            try await viewModel.fetchUserData()
            await checkLocationAccess()
            if longitude == 0.0 && latitude == 0.0 {
                showLocationScreen.toggle()
            } else {
                isAuthenticated = true
                showMainScreen.toggle()
                print("\(longitude), \(latitude)")
            }
        } catch {
            if retries > 0 {
                print("Profile fetch failed, retrying... (\(retries) attempts left)")
                try? await Task.sleep(nanoseconds: 1_000_000_000) // Wait for 1 second
                await fetchProfileWithRetry(retries: retries - 1)
            } else {
                alertItem = AlertItem(title: "Profile Error", message: "Failed to fetch user profile after multiple attempts. Please try again later.")
            }
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
            alertItem = AlertItem(title: "Error", message: "Failed to retrieve location: \(error.localizedDescription)")
        }
    }
    
    func validateInput(email: String, firstName: String, lastName: String, password: String) -> Bool {
        if firstName.isEmpty {
            alertItem = AlertItem(title: "Invalid Input", message: "First name cannot be empty.")
            return false
        }
        
        if lastName.isEmpty {
            alertItem = AlertItem(title: "Invalid Input", message: "Last name cannot be empty.")
            return false
        }
        
        if !isValidEmail(email) {
            alertItem = AlertItem(title: "Invalid Input", message: "Invalid email address.")
            return false
        }
        
        if password.count < 6 {
            alertItem = AlertItem(title: "Invalid Input", message: "Password must be at least 6 characters long.")
            return false
        }
        
        if !isTermsChecked {
            alertItem = AlertItem(title: "Terms and Conditions", message: "Please accept the terms and conditions to continue.")
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
    SignUpView()
}
