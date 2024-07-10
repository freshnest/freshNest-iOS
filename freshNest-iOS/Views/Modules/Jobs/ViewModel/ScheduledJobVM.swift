//
//  ScheduledJobVM.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import Foundation
import SwiftUI

class ScheduledJobCardViewModel: ObservableObject {
    @Published var data: ScheduledJobsModel
    @Published var navigation: Int?
    @Published var isJobInReview = false
    @Published var statusText = ""
    @Published var tasklistInfo = TaskListModel()

    init(data: ScheduledJobsModel) {
        self.data = data
    }

    var formattedDate: String {
        getFormattedTime(from: data.dateTime)
    }

    var statusColor: Color {
        switch statusText {
        case "In Review": return .orange
        case "Completed": return .green
        case "In Progress": return .blue
        case "Assigned": return .black
        default: return .black
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

    func checkJobStatus(supabaseClient: SupabaseManager) async {
        do {
            let reviewStatus: String = try await supabaseClient
                .supabase
                .rpc("check_status", params: ["j_id": data.jobID ?? ""])
                .execute()
                .value
            
            DispatchQueue.main.async {
                self.isJobInReview = !reviewStatus.isEmpty
                self.statusText = reviewStatus
            }
        } catch {
            print("Error checking job status: \(error)")
            // Handle error
        }
    }

    func viewJobInfo(supabaseClient: SupabaseManager) async {
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
            
            DispatchQueue.main.async {
                switch reviewStatus {
                case "In Review": self.navigation = 1
                case "Completed": self.navigation = 2
                default:
                    if let data = fetchedTasklist.first {
                        self.tasklistInfo = data
                    }
                    self.navigation = 3
                }
            }
        } catch {
            print("Error viewing job info: \(error)")
            // Handle error
        }
    }
}
