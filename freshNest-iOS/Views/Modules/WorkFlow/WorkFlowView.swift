//
//  WorkFlowView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 14/05/24.
//

import SwiftUI
import Storage

struct WorkFlowView: View {
    @Binding var data: TaskListModel
    @State private var listViewToggle = false
    @State private var showSuccessScreen = false
    @State private var isLoading = false
    @State private var showConfirmationAlert = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var supabaseClient: SupabaseManager
    var dateTime: String?
    
    private var allTasksComplete: Bool {
        guard let tasks = data.task, !tasks.isEmpty else { return false }
        return tasks.allSatisfy { $0.isComplete == true }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        Spacer()
                        Text(data.title ?? "Task List")
                            .font(.cascaded(ofSize: .h28, weight: .bold))
                            .accessibility(addTraits: .isHeader)
                            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        Spacer()
                        HStack {
                            BackButton()
                            Spacer()
                        }
                    }
                    .padding(.bottom, 16)
                    
                    HStack(alignment: .center) {
                        Text("Scheduled For: \(getFormattedTime(from: dateTime))")
                            .font(.cascaded(ofSize: .h20, weight: .medium))
                            .foregroundStyle(.black.opacity(0.8))
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    Text(data.notes ?? "")
                        .font(.cascaded(ofSize: .h16, weight: .regular))
                        .foregroundStyle(.black.opacity(0.6))
                }
                
                Spacer()
                List(data.task?.indices ?? 0..<0, id: \.self) { index in
                    TaskItemView(task: Binding(
                        get: { data.task?[index] ?? TaskModel() },
                        set: { data.task?[index] = $0 }
                    ), jobID: data.jobId?.uuidString ?? "", isLoading: $isLoading)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .padding(.horizontal, -16)
                
                if allTasksComplete {
                    RoundedButton(title: "Finish Job", action: {
                        showConfirmationAlert.toggle()
                    }, color: .black, textColor: .white)
                }
            }
            .padding(16)
        }
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
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $showSuccessScreen) {
            WorkFlowSuccessScreen()
        }
        .alert(isPresented: $showConfirmationAlert) {
            Alert(
                title: Text("Confirmation"),
                message: Text("Are you sure you want to submit this job?"),
                primaryButton: .default(Text("Yes")) {
                    //update call
                    Task {
                        do {
                            let response = try await supabaseClient.supabase.rpc("finish_job", params: ["j_id": data.jobId]).execute()
                            print("Successfully Completed the JOB\(String(describing: data.jobId))", response.status)
                            supabaseClient.fetchScheduledJobs()
                            showSuccessScreen.toggle()
                        } catch {
                            print("Error: \(error)")
                        }
                    }
                    
                },
                secondaryButton: .cancel(Text("No"))
            )
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
        
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
