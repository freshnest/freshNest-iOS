//
//  VacationModeView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct VacationModeView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Namespace var animation
    @State var isVacationModeEnabled = false
    @EnvironmentObject var supabaseClient: SupabaseManager
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 24) {
                HeaderCell(headerTitle: "Vacation Mode")
                VStack(alignment: .leading, spacing: 8) {
                    // supabaseClient.userProfile?.vacationMode ?? false
                    ToggleRow(text: "Enable Vacation Mode", bool: isVacationModeEnabled , onTap: {
                        
                        isVacationModeEnabled.toggle()
                        updateVacationMode(isOn: isVacationModeEnabled)
                    })
                    
                    Text(
                        "Activate this option to receive stop receiving recommended available jobs"
                    )
                    .font(.cascaded(ofSize: .h14, weight: .regular))
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            .onAppear{
                if let vacationMode = supabaseClient.userProfile?.vacationMode {
                    isVacationModeEnabled = vacationMode
                }
            }
            .padding(16)
        }
        .navigationBarBackButtonHidden()
    }
    
    func updateVacationMode(isOn: Bool){
        Task {
            do {
                let updatedProfile = CleanersModel(vacationMode: isOn)
                let currentUser = try await supabaseClient.supabase.auth.session.user
                let response = try await supabaseClient.supabase
                    .from("cleaners")
                    .update(updatedProfile)
                    .eq("id", value: UUID(uuidString: currentUser.id.uuidString))
                    .execute()
                print("\(response.response.statusCode): VacationMode Updated Successfully")
                try await supabaseClient.fetchUserData()
            } catch {
                print("Failed to update VacationMode: \(error.localizedDescription)")
            }
        }
    }
    
    @ViewBuilder
    public func ToggleRow(text: String, bool: Bool, smaller: Bool = false, onTap: @escaping () -> Void)
    -> some View {
        HStack(spacing: 12) {
            Text(text)
                .font(.cascaded(ofSize: .h18, weight: .regular))
                .lineLimit(1)
                .foregroundColor(Color.black)
            
            Spacer()
            
            ZStack(alignment: bool ? .trailing : .leading) {
                Capsule()
                    .frame(width: 42, height: 28)
                    .foregroundColor(bool ? .green : .gray.opacity(0.8))
                
                Circle()
                    .foregroundColor(Color.white)
                    .padding(2)
                    .frame(width: 28, height: 28)
            }
            .onTapGesture {
                withAnimation {
                    onTap()
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VacationModeView()
}
