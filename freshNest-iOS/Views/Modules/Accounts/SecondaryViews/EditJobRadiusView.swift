//
//  EditJobRadiusView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct EditJobRadiusView: View {
    @State private var selectedRadius: Int = 0
    @State private var initialRadius: Int = 0
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var supabaseClient: SupabaseManager
    var body: some View {
        VStack(spacing: 24) {
            HeaderCell(headerTitle: "Job Radius")
            
            HStack(spacing: 12) {
                Text("Select Radius")
                    .font(.cascaded(ofSize: .h18, weight: .regular))
                    .lineLimit(1)
                    .foregroundColor(Color.black.opacity(0.9))
                
                Spacer()
                
                Picker("Select Radius", selection: $selectedRadius) {
                    ForEach(Array(stride(from: 40, to: 110, by: 10)), id: \.self) { radius in
                        Text("\(radius) miles").tag(radius)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
            }
            .frame(height: 20)
            .frame(maxWidth: .infinity)
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            
            Spacer()
            
            if selectedRadius != initialRadius {
                RoundedButton(title: "Save", action: {
                    initialRadius = selectedRadius
                    updateJobRadius(jobRadius: String(initialRadius))
                    presentationMode.wrappedValue.dismiss()
                }, color: .black, textColor: .white)
            }
        }
        .padding(16)
        .navigationBarBackButtonHidden()
        .onAppear {
            if let selectedRadiusBackend = supabaseClient.userProfile?.jobRadius {
                selectedRadius = Int(selectedRadiusBackend) ?? initialRadius
            }
        }
    }
    
    func updateJobRadius(jobRadius: String){
        Task {
            do {
                let updatedProfile = CleanersModel(jobRadius: jobRadius)
                let currentUser = try await supabaseClient.supabase.auth.session.user
                let response = try await supabaseClient.supabase
                    .from("cleaners")
                    .update(updatedProfile)
                    .eq("id", value: UUID(uuidString: currentUser.id.uuidString))
                    .execute()
                print("\(response.response.statusCode): JobRadius Updated Successfully")
                supabaseClient.fetchUserData()
            } catch {
                print("Failed to update JobRadius: \(error.localizedDescription)")
            }
        }
    }
}


#Preview {
    EditJobRadiusView()
}
