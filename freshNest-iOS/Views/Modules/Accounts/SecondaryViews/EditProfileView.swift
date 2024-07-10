//
//  EditProfileView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var supabaseClient: SupabaseManager
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                ZStack(alignment: .center) {
                    HStack {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Image(systemName: "arrow.left")
                                .font(.system(.title2, design: .rounded).weight(.semibold))
                                .foregroundColor(Color.black)
                        }
                        Spacer()
                    }
                    Text("Profile")
                        .font(.cascaded(ofSize: .h28, weight: .bold))
                        .accessibility(addTraits: .isHeader)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                }
                
                NavigationLink(destination: EditShortTextView(titleText: "Edit Name", placeholderText: "First Name", ctaTitle: "Save", secondInput: true, action: {
                    // action
                    if !firstName.isEmpty && !lastName.isEmpty {
                        updateName(firstName: firstName, lastName: lastName)
                        resetStrings()
                    } else {
                        alertMessage = "Enter First Name and Last Name."
                        alertTitle = "Validation Error"
                        showAlert.toggle()
                    }
                }, inputText: $firstName, secondInputText: $lastName)) {
                    ProfileItemCell(systemImage: "", title: "Name", optionalText: "\(supabaseClient.userProfile?.firstName ?? "") \(supabaseClient.userProfile?.lastName ?? "")")
                }
                
                if let phoneNumberToShow = supabaseClient.userProfile?.phoneNumber {
                    let phoneNumberString = String(phoneNumberToShow)
                    let formattedPhoneNumber = phoneNumberString.formattedPhoneNumber()
                    NavigationLink(destination: EditShortTextView(titleText: "Edit Phone", placeholderText: supabaseClient.userProfile?.phoneNumber ?? "", ctaTitle: "Save", action: {
                        // action
                        if !phoneNumber.isEmpty && phoneNumber.count == 10 {
                            updatePhoneNumber(phoneNumber: phoneNumber)
                            resetStrings()
                        } else {
                            alertMessage = "Enter a 10 digit phone number."
                            alertTitle = "Validation Error"
                            showAlert.toggle()
                        }
                    }, inputText: $phoneNumber, secondInputText: $lastName)) {
                        ProfileItemCell(systemImage: "", title: "Phone", optionalText: formattedPhoneNumber)
                    }
                } else {
                    NavigationLink(destination: EditShortTextView(titleText: "Edit Phone", placeholderText: "Enter 10 digit phone number", ctaTitle: "Save", action: {
                        // action
                        print("\(phoneNumber)-> UPDATED PHONE")
                        if !phoneNumber.isEmpty && phoneNumber.count == 10 {
                            updatePhoneNumber(phoneNumber: phoneNumber)
                            resetStrings()
                        } else {
                            alertMessage = "Enter a 10 digit phone number."
                            alertTitle = "Validation Error"
                            showAlert.toggle()
                        }
                    }, inputText: $phoneNumber, secondInputText: $lastName)) {
                        ProfileItemCell(systemImage: "", title: "Phone", optionalText: "")
                    }
                }
                
                Button(action: {
                    alertMessage = "Email cannot be updated.\nFor enquiry or support contact us."
                    alertTitle = "Cannot Update Email"
                    showAlert.toggle()
                }){
                    ProfileItemCell(systemImage: "", title: "Email", optionalText: "\(supabaseClient.userProfile?.email ?? "")")
                }
                
                Spacer()
            }
            .padding(16)
        }
        .navigationBarBackButtonHidden()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    func updateEmail(email: String){
        Task {
            do {
                let updatedProfile = CleanersModel(email: email)
                let currentUser = try await supabaseClient.supabase.auth.session.user
                let response = try await supabaseClient.supabase
                    .from("cleaners")
                    .update(updatedProfile)
                    .eq("id", value: UUID(uuidString: currentUser.id.uuidString))
                    .execute()
                print("\(response.response.statusCode): Email Updated Successfully")
                try await supabaseClient.fetchUserData()
            } catch {
                print("Failed to update email: \(error.localizedDescription)")
            }
        }
    }
    
    func updatePhoneNumber(phoneNumber: String){
        Task {
            do {
                let updatedProfile = CleanersModel(phoneNumber: phoneNumber)
                let currentUser = try await supabaseClient.supabase.auth.session.user
                let response = try await supabaseClient.supabase
                    .from("cleaners")
                    .update(updatedProfile)
                    .eq("id", value: UUID(uuidString: currentUser.id.uuidString))
                    .execute()
                print("\(response.response.statusCode): Phone Updated Successfully")
                try await supabaseClient.fetchUserData()
            } catch {
                print("Failed to update phone: \(error.localizedDescription)")
            }
        }
    }
    
    func updateName(firstName: String, lastName: String){
        Task {
            do {
                let updatedProfile = CleanersModel(firstName: firstName, lastName: lastName)
                let currentUser = try await supabaseClient.supabase.auth.session.user
                let response = try await supabaseClient.supabase
                    .from("cleaners")
                    .update(updatedProfile)
                    .eq("id", value: UUID(uuidString: currentUser.id.uuidString))
                    .execute()
                print("\(response.response.statusCode): Name Updated Successfully")
                try await supabaseClient.fetchUserData()
            } catch {
                print("Failed to update Name: \(error.localizedDescription)")
            }
        }
    }
    
    func resetStrings() {
        firstName = ""
        lastName = ""
        phoneNumber = ""
        email = ""
    }
}

//#Preview {
//    EditProfileView()
//}

extension String {
    func formattedPhoneNumber() -> String {
        // Ensure the phone number string contains only digits
        let digits = self.filter { $0.isNumber }
        
        // Check if the phone number has the required length
        guard digits.count == 10 else {
            return self
        }
        
        // Format the phone number as +1 (XXX) XXXXX
        let areaCode = digits.prefix(3)
        let remaining = digits.suffix(7)
        let formatted = "+1 (\(areaCode)) \(remaining.prefix(5))\(remaining.suffix(2))"
        
        return formatted
    }
}
