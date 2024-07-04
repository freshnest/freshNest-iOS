//
//  JobCardCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct AvailableJobCardCell: View {
    var data: AvailableJobModel
    @State var showPropertyInfoView: Bool = false
    @State var propertyInfo: PropertyInfoModel = PropertyInfoModel()
    @EnvironmentObject var supabaseClient: SupabaseManager
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .center) {
                        Text(getFormattedTime(from: data.createdAt))
                            .foregroundStyle(.white)
                            .font(.cascaded(ofSize: .h14, weight: .regular))
                    }
                    .padding(4)
                    .frame(maxWidth: 70, alignment: .leading)
                    .background(Color.black)
                    .padding(.leading, -16)
                    .padding(.top, -16)
                    .padding(.bottom, -8)
                    
                    Text("$\(data.price ?? "")")
                        .font(.cascaded(ofSize: .h22, weight: .medium))
                        .foregroundColor(Color.black.opacity(0.9))
                        .lineLimit(1)
                }
                
                Spacer()
                
                Text("\(data.bedroom ?? 0) Bed, \(data.bathroom ?? 0) Bath")
                    .font(.cascaded(ofSize: .h22, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.5))
                    .lineLimit(1)
            }
            
            VStack(alignment: .leading, spacing: 4) {
//                Text(data.timeToDestination)
//                    .font(.cascaded(ofSize: .h18, weight: .medium))
//                    .foregroundColor(Color.black.opacity(0.9))
//                    .lineLimit(1)
                Text("Location: \(data.addressJSON?.street ?? ""), \(data.addressJSON?.city ?? ""), \(data.addressJSON?.state ?? "")")
                    .font(.cascaded(ofSize: .h16, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.9))
                    .lineLimit(1)
            }
            NotSoRoundedButton(title: "View Job Info", action: {
                Task {
                    do {
                        let currentUser = try await supabaseClient.supabase.auth.session.user
                         
                        let property: [PropertyInfoModel] = try await supabaseClient
                            .supabase
                            .from(Table.propertyInfo)
                            .select()
                            .eq("property_id", value: data.propertyId)
                            .execute()
                            .value
                        if let data = property.first {
                            propertyInfo = data
                        }
                        print(propertyInfo)
                        showPropertyInfoView.toggle()
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
        }
        .fullScreenCover(isPresented: $showPropertyInfoView) {
            PropertyInfoView(data: $propertyInfo, jobID: data.jobID ?? "", isMatchCTAShow: true)
        }
        .padding()
        .frame(maxWidth: 400, alignment: .leading)
        .background(Color(hex: "#F7F7F7"))
        .cornerRadius(10)
    }
    
    func getFormattedTime(from createdAt: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let dateString = createdAt,
              let date = dateFormatter.date(from: dateString) else {
            return "Invalid date"
        }
        dateFormatter.dateFormat = "MM/dd/yy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

struct ScheduledJobCardCell: View {
    var data: ScheduledJobsModel
    @State var showTaskListInfoView = false
    @State var tasklistInfo: TaskListModel = TaskListModel()
    @EnvironmentObject var supabaseClient: SupabaseManager
    @State private var navigation: Int? = 0
    @State private var showSuccessScreen = false
    @State private var isJobInReview = false
    @State private var statusText = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .center) {
                        Text(getFormattedTime(from: data.dateTime))
                            .foregroundStyle(.white)
                            .font(.cascaded(ofSize: .h14, weight: .regular))
                    }
                    .padding(4)
                    .frame(maxWidth: 70, alignment: .leading)
                    .background(Color.black)
                    .padding(.leading, -16)
                    .padding(.top, -16)
                    .padding(.bottom, -8)
                    
                    Text("$\(data.price ?? "")")
                        .font(.cascaded(ofSize: .h22, weight: .medium))
                        .foregroundColor(Color.black.opacity(0.9))
                        .lineLimit(1)
                }
                
                Spacer()
                VStack (alignment: .trailing, spacing: 0) {
                    if isJobInReview {
                        Text(statusText)
                            .foregroundStyle(getStatusColor(for: statusText))
                            .font(.cascaded(ofSize: .h16, weight: .bold))
                    }
                    Text("\(data.bedroom ?? 0) Bed, \(data.bathroom ?? 0) Bath")
                        .font(.cascaded(ofSize: .h22, weight: .medium))
                        .foregroundColor(Color.black.opacity(0.5))
                        .lineLimit(1)
                }
            }
            
            ZStack {
                NavigationLink(destination: WorkFlowInReviewScreen(), tag: 1, selection: $navigation) { EmptyView() }
                NavigationLink(destination: WorkFlowCompletedScreen(), tag: 2, selection: $navigation) { EmptyView() }
                NavigationLink(destination: WorkFlowView(data: $tasklistInfo, dateTime: data.dateTime), tag: 3, selection: $navigation) { EmptyView() }
            }
            .opacity(0)
            .frame(width: 0, height: 0)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Location: \(data.addressJSON?.street ?? ""), \(data.addressJSON?.city ?? ""), \(data.addressJSON?.state ?? "")")
                    .font(.cascaded(ofSize: .h16, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.9))
                    .lineLimit(1)
            }
            
            NotSoRoundedButton(title: "View Job Info", action: {
                Task {
                    do {
                        let fetchedTasklist: [TaskListModel] = try await supabaseClient
                            .supabase
                            .from(Table.tasklist)
                            .select()
                            .eq("job_id", value: data.jobID)
                            .execute()
                            .value
                        
                        let reviewStatus: String = try await supabaseClient
                            .supabase
                            .rpc("check_status", params: ["j_id": data.jobID ?? ""])
                            .execute()
                            .value
                        print("REVIEW STATUS: \(reviewStatus)")
                        if reviewStatus == "In Review" {
                            self.navigation = 1
                        } else if reviewStatus == "Completed" {
                            self.navigation = 2
                        } else {
                            if let data = fetchedTasklist.first {
                                tasklistInfo = data
                            }
                            print(tasklistInfo)
                            self.navigation = 3
                        }
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
        }
        .padding()
        .frame(maxWidth: 400, alignment: .leading)
        .background(Color(hex: "#F7F7F7"))
        .cornerRadius(10)
        .onAppear {
            Task {
                do {
                    let reviewStatus: String = try await supabaseClient
                        .supabase
                        .rpc("check_status", params: ["j_id": data.jobID ?? ""])
                        .execute()
                        .value
                    
                    isJobInReview = !reviewStatus.isEmpty
                    statusText = reviewStatus
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func getFormattedTime(from dateTime: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let dateString = dateTime,
              let date = dateFormatter.date(from: dateString) else {
            return "Invalid date"
        }
        
        dateFormatter.dateFormat = "MM/dd/yy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func getStatusColor(for status: String) -> Color {
        switch status {
        case "In Review":
            return .orange
        case "Completed":
            return .green
        case "In Progress":
            return .blue
        case "Assigned":
            return .black
        default:
            return .black
        }
    }
}
