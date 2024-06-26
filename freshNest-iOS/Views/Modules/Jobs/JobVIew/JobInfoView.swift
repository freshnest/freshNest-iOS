//
//  JobInfoView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 16/05/24.
//

import SwiftUI
struct PropertyInfoView: View {
    @Binding var data: PropertyInfoModel
    @EnvironmentObject var supabaseClient: SupabaseManager
    @Environment(\.presentationMode) var presentationMode
    let generator = UIImpactFeedbackGenerator(style: .medium)
    @State var isLoading = false
    var jobID: String
    var isMatchCTAShow = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("airbnbPlaceholderImage")
                .resizable()
                .frame(height: 250)
                .scaledToFit()
                .overlay {
                    VStack(alignment: .leading) {
                        HStack {
                            BackButton()
                                .padding(8)
                                .background(
                                    Circle()
                                        .stroke(.black, lineWidth: 1)
                                        .foregroundStyle(.white)
                                )
                            Spacer()
                        }
                        .padding(.top, 16)
                        Spacer()
                        Divider()
                            .padding(.horizontal, -16)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 32)
            
            VStack(alignment: .leading, spacing: 16) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 4) {
                            Text("Property Type: \(data.propertyType ?? "")")
                                .font(.cascaded(ofSize: .h16, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(4)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.black.opacity(0.5), lineWidth: 1)
                                )
                            Spacer()
                        }
                        
                        Text("\(data.propertyName ?? "")")
                            .font(.cascaded(ofSize: .h28, weight: .bold))
                        
                        HStack(alignment: .center, spacing: 4) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 18))
                            
                            Text("\(data.addressJSON?.street ?? ""), \(data.addressJSON?.city ?? ""), \(data.addressJSON?.state ?? "")")
                                .font(.cascaded(ofSize: .h20, weight: .regular))
                                .foregroundStyle(.black.opacity(0.4))
                            Spacer()
                            
                        }

                        
                        Text("Work Items")
                            .font(.cascaded(ofSize: .h20, weight: .bold))
                            .padding(.top, 32)
                        
                        
                        VStack(spacing: 8) {
                            WorkItemCell(image: "bed.double.fill", text: "Bedroom: ", value: String(data.bedroomCount ?? 0))
                            WorkItemCell(image: "shower.fill", text: "Bathroom: ", value: String(data.bathroomCount ?? 0))
                            let isLaundryMachineAvailable = data.isLaundryMachineAvailable ?? false
                            WorkItemCell(image: "washer.fill", text: "Laundry Machine: ", value: isLaundryMachineAvailable ? "Yes" : "No")
                            let isCleaningSuppliesAvailable = data.isCleaningSuppliesAvailable ?? false
                            WorkItemCell(image: "bubbles.and.sparkles.fill" , text: "Cleaning Supplies: ", value: isCleaningSuppliesAvailable ? "Yes" : "No")
                        }
                        Spacer()
                    }
                }
                if isMatchCTAShow {
                    VStack {
                        Divider()
                            .padding(.horizontal, -16)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Payout Amount")
                                    .font(.cascaded(ofSize: .h16, weight: .regular))
                                    .foregroundStyle(.gray)
                                Text("$\(data.cleaningFee ?? "")")
                                    .font(.cascaded(ofSize: .h28, weight: .bold))
                            }
                            Spacer()
                            HStack {
                                Text("Match")
                                    .font(.cascaded(ofSize: .h20, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: 150)
                                    .background( LinearGradient(
                                        gradient: Gradient(colors: [Color(hex: AppUserInterface.Colors.gradientColor1), Color(hex: AppUserInterface.Colors.gradientColor1), Color(hex: AppUserInterface.Colors.gradientColor3)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    ))
                                    .cornerRadius(30)
                            }
                            .onTapGesture {
                                generator.impactOccurred()
                                isLoading = true
                                supabaseClient.matchWithJob(jobID: jobID)
                                supabaseClient.fetchAvailableJobs{ success in
                                    DispatchQueue.main.async {
                                        isLoading = false
                                        if success {
                                            presentationMode.wrappedValue.dismiss()
                                        } else {
                                            // why would this come here??
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 16)
                    }
                    .frame(height: 100)
                }
                
            }
            .padding(16)
        }
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden()
        .overlay(
            ZStack {
                if isLoading {
                    GlassBackGround(color: .black)
                        .ignoresSafeArea(.all)
                    GrowingArcIndicatorView(color: Color(hex: AppUserInterface.Colors.gradientColor1), lineWidth: 2)
                        .frame(width: 50)
                }
            }
        )
    }
}

struct WorkItemCell: View {
    var image: String
    var text: String
    var value: String
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: image)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.black)
            Text(text)
                .font(.cascaded(ofSize: .h20, weight: .regular))
            Text(value)
                .font(.cascaded(ofSize: .h20, weight: .regular))
            Spacer()
        }
    }
}

//#Preview {
//    PropertyInfoView(data: .constant(PropertyInfoModel(propertyId: "", createdAt: Date(), propertyType: "Apartment", bedroomCount: 3, isLaundryMachineAvailable: true, isCleaningSuppliesAvailable: true, updatedAt: Date(), hostId: UUID(), cleaningFee: "191", addressJSON: Address(zip: "", city: "Boston", state: "MA", number: "12123", street: "Blue Stree", aptNumber: "123"), bathroomCount: 4, propertyName: "Havenwood Estate")))
//}
