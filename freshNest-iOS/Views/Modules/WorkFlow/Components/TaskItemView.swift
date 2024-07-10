//
//  TaskItemView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI
import Storage

//Color(hex: "#00E676")
struct TaskItemView: View {
    @Binding var task: TaskModel
    var jobID: String
    @Binding var isLoading: Bool
    @State private var showSubtasks = false
    @State private var subtaskStatus: [Bool]
    @State private var selectedImages: [UIImage?] = [nil, nil, nil]
    @State private var selectedImageIndex = 0
    @State private var isImagePickerPresented = false
    @EnvironmentObject var supabaseClient: SupabaseManager
    
    init(task: Binding<TaskModel>, jobID: String, isLoading: Binding<Bool>) {
        self._task = task
        self.jobID = jobID
        self._isLoading = isLoading
        self._subtaskStatus = State(initialValue: Array(repeating: false, count: task.wrappedValue.subtasks?.count ?? 0))
    }
    
    var allSubtasksCompleted: Bool {
        !subtaskStatus.contains(false)
    }
    
    var allSubtasksCompletedAndVerified: Bool {
        !subtaskStatus.contains(false) && selectedImages.contains { $0 != nil }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if allSubtasksCompletedAndVerified {
                    Text("Completed")
                        .font(.cascaded(ofSize: .h12, weight: .regular))
                        .foregroundStyle(Color(hex: "#00E676"))
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(Color(hex: "#00E676").opacity(0.2))
                        )
                } else {
                    Text("In progress")
                        .font(.cascaded(ofSize: .h12, weight: .regular))
                        .foregroundStyle(Color(hex: "#3E90F0"))
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(Color(hex: "#3E90F0").opacity(0.2))
                        )
                }
                Spacer()
            }
            HStack {
                Text(task.title ?? "")
                    .font(.cascaded(ofSize: .h24, weight: .bold))
                Spacer()
                Image(systemName: showSubtasks ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                    .foregroundColor(.black.opacity(0.8))
                    .onTapGesture {
                        showSubtasks.toggle()
                    }
            }
            Text(task.description ?? "")
                .foregroundColor(.secondary)
                .font(.cascaded(ofSize: .h16, weight: .regular))
            
            if showSubtasks {
                ForEach(task.subtasks?.indices ?? 0..<0, id: \.self) { index in
                    SubtaskView(subtask: task.subtasks?[index], isChecked: $subtaskStatus[index])
                        .onTapGesture {
                            subtaskStatus[index].toggle()
                        }
                }
                if allSubtasksCompleted {
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(80), spacing: 2), count: 3), alignment: .leading) {
                        ForEach(selectedImages.indices, id: \.self) { index in
                            ZStack {
                                if let image = selectedImages[index] {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 70, height: 70)
                                        .cornerRadius(8)
                                        .onTapGesture {
                                            selectedImageIndex = index
                                            isImagePickerPresented = true
                                        }
                                } else {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.gray, lineWidth: 1)
                                            .frame(width: 70, height: 70)
                                            .overlay {
                                                Image(systemName: "plus")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .foregroundStyle(.black.opacity(0.5))
                                                    .onTapGesture {
                                                        selectedImageIndex = index
                                                        isImagePickerPresented = true
                                                    }
                                            }
                                    }
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(image: $selectedImages[selectedImageIndex])
                    }
                    Text("Select at least one image for verification of the completed task!")
                        .lineLimit(2, reservesSpace: true)
                        .foregroundColor(.secondary)
                        .font(.cascaded(ofSize: .h14, weight: .regular))
                    if selectedImages.contains(where: { $0 != nil }) {
                        RoundedButton(title: "Submit verification images", action: {
                            saveImages{
                                showSubtasks.toggle()
                            }
                        }, color: .black, textColor: .white)
                    }
                }
            }
            HStack {
                Image(systemName: "list.clipboard")
                    .resizable()
                    .frame(width: 12, height: 16)
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appPrimaryBlue))
                Text("\(task.subtasks?.count ?? 0) Sub-Task")
                    .font(.cascaded(ofSize: .h12, weight: .medium))
                    .foregroundStyle(.gray)
            }
        }
        .onChange(of: allSubtasksCompletedAndVerified) { newValue in
            task.isComplete = newValue
        }
        .onAppear {
            Task {
                do {
                    let images = try await downloadImages(jobID: jobID, task: task)
                    selectedImages = images
                } catch {
                    print("Failed to download images: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func saveImages(completion: @escaping () -> Void) {
        isLoading = true
        Task {
            do {
                let currentUser = try await supabaseClient.supabase.auth.session.user
                
                for (index, image) in selectedImages.enumerated() {
                    if let image = image, let imageData = image.jpegData(compressionQuality: 0.1) {
                        let fileName = "\(jobID)/\(task.taskID ?? UUID())/\(task.title ?? "")-image\(index+1).jpeg"
                        print(fileName)
                        let response = try await supabaseClient
                            .supabase
                            .storage
                            .from("cleaning_verification")
                            .upload(path: fileName, file: imageData, options: FileOptions(contentType: "image/jpeg", upsert: true))
                        
                        print(response)
                        print(response.fullPath)
                        isLoading = false
                    }
                }
                completion()
            } catch {
                print("Failed to upload images: \(error.localizedDescription)")
            }
        }
    }
    
    func downloadImages(jobID: String, task: TaskModel) async throws -> [UIImage?] {
        var images: [UIImage?] = [nil, nil, nil]
        
        for index in 0...2 {
            let fileName = "\(jobID)/\(task.taskID ?? UUID())/\(task.title ?? "")-image\(index+1).jpeg"
            do {
                let data = try await supabaseClient.supabase.storage.from("cleaning_verification").download(path: fileName)
                if let image = UIImage(data: data) {
                    images[index] = image
                    subtaskStatus = subtaskStatus.map { _ in true }
                } else {
                    print("Failed to convert data to image for index \(index)")
                }
            } catch {
                print("Failed to download image for index \(index): As data is not present")
            }
        }
        return images
    }
}
