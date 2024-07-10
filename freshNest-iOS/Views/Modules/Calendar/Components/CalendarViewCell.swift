//
//  CalendarViewCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

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
