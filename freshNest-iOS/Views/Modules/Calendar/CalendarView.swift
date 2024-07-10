//
//  CalendarView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/05/24.
//

import SwiftUI

struct CalendarView: View {
    @State var selectedDate = Date()
    @EnvironmentObject var supabaseClient: SupabaseManager
    let generator = UIImpactFeedbackGenerator(style: .medium)
    @State private var navigation: Int? = 0
    @State var propertyInfo: PropertyInfoModel = PropertyInfoModel()
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack {
                    CalendarViewCell(selectedDate: $selectedDate)
                        .padding(.top, 16)
                    Divider()
                        .padding(.horizontal, -16)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            let jobs = chunkedJobs(for: selectedDate)
                            NavigationLink(destination: PropertyInfoView(data: $propertyInfo,jobID: "", isMatchCTAShow: false), tag: 1, selection: $navigation) {
                                EmptyView()
                            }
                            if jobs.isEmpty {
                                EmptyStateView(message: "You don't have any scheduled jobs for \(convertDateToString(date: selectedDate)).", imageText: "🗓️")
                                    .padding(.top, 16)
                            } else {
                                ForEach(jobs, id: \.self) { jobGroup in
                                    VStack {
                                        ForEach(jobGroup.indices, id: \.self) { index in
                                            let data = jobGroup[index]
                                            VStack(spacing: 0) {
                                                
                                                Button(action: {
                                                    generator.impactOccurred()
                                                    Task {
                                                        do {
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
                                                            self.navigation = 1
                                                        } catch {
                                                            print("Error: \(error)")
                                                        }
                                                    }
                                                }) {
                                                    CalendarViewItemCell(
                                                        amount: "$\(data.price ?? "")",
                                                        workItems: "\(data.bedroom ?? 0) Bed, \(data.bathroom ?? 0) Bath",
                                                        address: "\(data.addressJSON?.street ?? ""), \(data.addressJSON?.city ?? ""), \(data.addressJSON?.state ?? "")"
                                                    )
                                                }
                                                if index < jobGroup.count - 1 {
                                                    Divider()
                                                }
                                            }
                                            .padding(.bottom, 8)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(.black.opacity(0.2), lineWidth: 1)
                                            .fill(Color.white)
                                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                                            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -3, y: -3)
                                    )
                                    .padding(.horizontal, 16)
                                }
                            }
                        }
                        .padding(.top, 16)
                    }
                    
                    Spacer()
                }
                .onAppear {
                    supabaseClient.fetchScheduledJobs()
                }
            }
        }
    }
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    func filteredJobs(for date: Date) -> [ScheduledJobsModel] {
        let calendar = Calendar.current
        return supabaseClient.scheduledJobsArray.filter { job in
            guard let jobDate = job.dateTime, let jobDateObj = ISO8601DateFormatter().date(from: jobDate) else {
                return false
            }
            return calendar.isDate(jobDateObj, inSameDayAs: date)
        }
    }
    
    func chunkedJobs(for date: Date) -> [[ScheduledJobsModel]] {
        let filteredJobs = filteredJobs(for: date)
        let chunkedArray = stride(from: 0, to: filteredJobs.count, by: 3).map {
            Array(filteredJobs[$0..<min($0 + 3, filteredJobs.count)])
        }
        return chunkedArray
    }
}

#Preview {
    //    CalendarViewItemCell()
    CalendarView()
}

