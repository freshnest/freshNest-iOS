//
//  WorkingHoursView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct WorkingHoursView: View {
    @State private var workingHours: [DayWorkingHours] = DayWorkingHours.defaultHours()
    @State private var initialWorkingHours: [DayWorkingHours] = DayWorkingHours.defaultHours()
    @State private var isModified: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var supabaseClient: SupabaseManager
    var body: some View {
        VStack(spacing: 24) {
            HeaderCell(headerTitle: "Working Hours")
            WorkingHoursHeaderCell()
            ScrollView(showsIndicators: false) {
                ForEach(workingHours.indices, id: \.self) { index in
                    VStack(spacing: 0) {
                        DayWorkingHoursView(dayWorkingHours: $workingHours[index], onChanged: checkIfModified)
                        Divider()
                    }
                }
            }
            Spacer()
            
            if isModified {
                RoundedButton(title: "Save", action: {
                    // call updateWorkers
                    updateWorkHours(workingHours: workingHours)
                    presentationMode.wrappedValue.dismiss()
                }, color: .black, textColor: .white)
            }
        }
        .onAppear {
            if let fetchedWorkingHours = supabaseClient.userProfile?.workingHours {
                workingHours = mapToDayWorkingHours(fetchedWorkingHours)
            }
        }
        .padding(16)
        .navigationBarBackButtonHidden()
    }
    
    func updateWorkHours(workingHours: [DayWorkingHours]) {
        Task {
            do {
                var updatedWorkingHours = [String: TimeRange]()
                for dayWorkingHours in workingHours {
                    updatedWorkingHours[dayWorkingHours.day] = dayWorkingHours.toTimeRange()
                }
                
                var updatedProfile = CleanersModel()
                updatedProfile.workingHours = updatedWorkingHours
                
                let currentUser = try await supabaseClient.supabase.auth.session.user
                let response = try await supabaseClient.supabase
                    .from("cleaners")
                    .update(updatedProfile)
                    .eq("id", value: UUID(uuidString: currentUser.id.uuidString))
                    .execute()
                
                print("\(response.response.statusCode): WorkHours Updated Successfully")
                supabaseClient.fetchUserData()
            } catch {
                print("Failed to update WorkHours: \(error.localizedDescription)")
            }
        }
    }
    
//    private func checkIfModified() {
//        for index in workingHours.indices {
//            if workingHours[index] != initialWorkingHours[index] {
//                isModified = true
//                return
//            }
//        }
//        isModified = false
//    }
    
    func checkIfModified() {
        isModified = (workingHours != initialWorkingHours)
    }
    
    func mapToDayWorkingHours(_ data: [String: TimeRange]) -> [DayWorkingHours] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let dayOrder = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        
        var workingHours = data.compactMap { (day, timeRange) -> DayWorkingHours? in
            guard
                let fromTime = dateFormatter.date(from: timeRange.from),
                let toTime = dateFormatter.date(from: timeRange.to)
            else {
                return nil
            }
            return DayWorkingHours(day: day, fromTime: fromTime, toTime: toTime)
        }
        
        
        workingHours.sort {
            guard let firstIndex = dayOrder.firstIndex(of: $0.day),
                  let secondIndex = dayOrder.firstIndex(of: $1.day) else {
                return false
            }
            return firstIndex < secondIndex
        }
        
        return workingHours
    }
}

struct DayWorkingHours: Equatable {
    var day: String
    var fromTime: Date
    var toTime: Date
    static func defaultHours() -> [DayWorkingHours] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let defaultFromTime = dateFormatter.date(from: "8:00 AM") ?? Date()
        let defaultToTime = dateFormatter.date(from: "7:00 PM") ?? Date()
        
        let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        return days.map { DayWorkingHours(day: $0, fromTime: defaultFromTime, toTime: defaultToTime) }
    }
}

struct DayWorkingHoursView: View {
    @Binding var dayWorkingHours: DayWorkingHours
    var onChanged: () -> Void
    
    var body: some View {
        HStack {
            Text(dayWorkingHours.day)
                .font(.cascaded(ofSize: .h18, weight: .medium))
            Spacer()
            HStack {
                DatePicker("", selection: $dayWorkingHours.fromTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .onChange(of: dayWorkingHours.fromTime) { _ in
                        onChanged()
                    }
                DatePicker("", selection: $dayWorkingHours.toTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .onChange(of: dayWorkingHours.toTime) { _ in
                        onChanged()
                    }
                
            }
        }
        .padding(.vertical, 8)
        .cornerRadius(8)
    }
}

extension DayWorkingHours {
    func toTimeRange() -> TimeRange {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let fromTimeString = dateFormatter.string(from: fromTime)
        let toTimeString = dateFormatter.string(from: toTime)
        
        return TimeRange(from: fromTimeString, to: toTimeString)
    }
}

struct WorkingHoursHeaderCell: View {
    var body: some View {
        HStack {
            HStack {
                Text("Day")
                    .font(.cascaded(ofSize: .h18, weight: .medium))
                Spacer()
            }
            HStack {
                Text("From")
                    .font(.cascaded(ofSize: .h18, weight: .medium))
                Spacer()
                Text("To")
                    .font(.cascaded(ofSize: .h18, weight: .medium))
                Spacer()
            }
        }
    }
}

#Preview {
    WorkingHoursView()
}
