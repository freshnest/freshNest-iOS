//
//  JobInfoView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 16/05/24.
//

import SwiftUI

//struct JobModel: Identifiable, Hashable {
//    let id = UUID()
//    var jobType: JobType
//    var amount: String
//    var workItems: String
//    var timeToDestination: String
//
//    var date: Date
//
//    static func == (lhs: JobModel, rhs: JobModel) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}

struct JobInfoView: View {
    var data: JobModel?
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("airbnbPlaceholderImage")
                .resizable()
                .frame(height: 260)
                .scaledToFit()
                .opacity(0.9)
                .overlay {
                    VStack(alignment: .leading) {
                        HStack {
                            BackButton()
                                .padding(8)
                                .background(
                                    Circle()
                                        .foregroundStyle(.white)
                                )
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.top, 32)
                    .padding(16)
                }
            
            VStack(alignment: .leading) {
                Text("Centre Place Graslin - 14th Street")
                    .font(.system(size: 32, weight: .bold))
                
                HStack {
                    Text(data?.address ?? "Fenway, Boston, Massachusetts")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.black.opacity(0.4))
                    Spacer()
                    
                }
                
                HStack {
                    Text(data?.timeToDestination ?? "15 mins away")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.green)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(hex: "#00E676").opacity(0.2))
                        )
                    Spacer()
                }
                
                Text("Work Items")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.top, 32)
                
                //                NonInteractiveMapView()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        WorkItemCell(image: "bed.double", text: "1 Bedroom")
                        WorkItemCell(image: "shower", text: "1 Bathroom")
                        WorkItemCell(image: "toilet", text: "1 Toilet")
                        WorkItemCell(image: "fork.knife" , text: "1 Kitchen")
                    }
                }
                Spacer()
                
                Divider()
                    .padding(.horizontal, -16)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Payout Amount")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.gray)
                        Text(data?.amount ?? "$77")
                            .font(.system(size: 20, weight: .bold))
                    }
                    Spacer()
                    HStack {
                        Text("Match")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)                            .padding()
                            .frame(minWidth: 0, maxWidth: 150)
                            .background( LinearGradient(
                                gradient: Gradient(colors: [Color(hex: AppUserInterface.Colors.gradientColor1), Color(hex: AppUserInterface.Colors.gradientColor1), Color(hex: AppUserInterface.Colors.gradientColor3)]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .cornerRadius(30)
                    }
                    .onTapGesture {
                        // action
                    }
                }
                .padding(.vertical, 16)
                
            }
            .padding(16)
            Spacer()
        }
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden()
    }
}

struct WorkItemCell: View {
    var image: String
    var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
                .foregroundColor(.white)
                .frame(width: 120, height: 120)
                .overlay(
                    VStack(alignment: .center) {
                        Image(systemName: image)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text(text)
                            .font(.system(size: 14, weight: .medium))
                        
                    }
                        .padding(18)
                        .frame(maxWidth: .infinity)
                )
        }
    }
}

#Preview {
    JobInfoView()
}
