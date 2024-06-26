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
                                            .fill(Color.white)
                                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
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

struct CalendarViewItemCell: View {
    var amount: String
    var workItems: String
    var address: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(workItems)
                    .font(.cascaded(ofSize: .h18, weight: .medium))
                    .foregroundStyle(.black)
                Spacer()
                Text(amount)
                    .font(.cascaded(ofSize: .h18, weight: .regular))
                    .foregroundStyle(.black)
            }
            Text(address)
                .font(.cascaded(ofSize: .h14, weight: .regular))
                .foregroundStyle(.black)
        }
        .padding(8)
    }
}
#Preview {
    //    CalendarViewItemCell()
    CalendarView()
}

struct CalendarViewCell: View {
    @Binding var selectedDate: Date
    private let dayRange = -14...21
    @State var appear = false
    @EnvironmentObject var supabaseClient: SupabaseManager
    var formattedMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM,"
        return formatter.string(from: selectedDate)
    }
    var formattedYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: selectedDate)
    }
    var body: some View {
        VStack(spacing: 4){
            HStack(alignment: .bottom, spacing: 4) {
                Text(formattedMonth)
                    .font(.cascaded(ofSize: .h24, weight: .medium))
                Text(formattedYear)
                    .font(.cascaded(ofSize: .h18, weight: .regular))
                    .foregroundStyle(.black.opacity(0.4))
            }
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    LazyHStack(alignment: .center, spacing: 8) {
                        ForEach(dayRange, id: \.self) { offset in
                            let weekDayDate = Calendar.current.date(byAdding: .day, value: offset, to: Date())!
                            CalendarDateView(date: weekDayDate, isSelected: selectedDate.isSameDay(as: weekDayDate), hasJob: hasJobs(for: weekDayDate)) {
                                selectedDate = weekDayDate
                                value.scrollTo(selectedDate, anchor: .center)
                            }
                            .id(offset)
                        }
                        .onAppear {
                            value.scrollTo(0, anchor: .center)
                        }
                    }
                }
            }
        }
        .frame(maxHeight: 150)
    }
    func hasJobs(for date: Date) -> Bool {
        return !filteredJobs(for: date).isEmpty
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
}

struct CalendarDateView: View {
    var date: Date
    var isSelected: Bool
    var hasJob: Bool
    var action: () -> Void
    @State var translation: CGSize = .zero
    @State var offset = 0.0
    
    init(date: Date, isSelected: Bool, hasJob: Bool, action: @escaping () -> Void) {
        self.date = date
        self.isSelected = isSelected
        self.hasJob = hasJob
        self.action = action
        
        let key = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                if hasJob {
                    HStack(spacing: 2) {
                        Circle()
                            .foregroundStyle(.blue)
                            .frame(width: 4, height: 4)
                    }
                }
                Text(String(format: "%02d", Calendar.current.component(.day, from: date)))
                    .font(.cascaded(ofSize: .h24, weight: .bold))
                    .foregroundColor(.black.opacity(0.7))
                
                Text(date.weekdayLetter).textCase(.uppercase)
                    .font(.cascaded(ofSize: .h12, weight: .regular))
                    .foregroundColor(isSelected ? .black : .gray)
                
                if isSelected {
                    withAnimation(.easeInOut(duration: 0.3)){
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 20, height: 2)
                    }
                }
                
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ?Color.black.opacity(0.3) :Color.black.opacity(0.1), lineWidth: 1)
                    .foregroundStyle(.gray)
            )
            .scaleEffect(isSelected ? 1.3 : 1)
        }
        .padding(4)
        .buttonStyle(PlainButtonStyle())
        .onTapGesture {
            action()
        }
    }
}

extension Date {
    var startOfWeek: Date? {
        Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
    
    func isSameDay(as otherDate: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: otherDate)
    }
    
    var dayOfWeekText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    var dayMonthText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: self)
    }
    
    var weekdayLetter: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
    
    func isInPastOrToday() -> Bool {
        return self.compare(Date()) != .orderedDescending
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        let tomorrow = Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date()
//        return CalendarView(selectedDate: .constant(tomorrow))
//    }
//}
