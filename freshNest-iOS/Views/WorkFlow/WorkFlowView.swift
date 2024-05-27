//
//  WorkFlowView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 14/05/24.
//

import SwiftUI

struct WorkFlowView: View {
    @State private var listViewToggle = false
    @State private var showSuccessScreen = false
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        Spacer()
                        Text("Task List")
                            .font(.system(size: 28, weight: .bold))
                            .accessibility(addTraits: .isHeader)
                            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        Spacer()
                        HStack {
                            BackButton()
                            Spacer()
                        }
                    }
                    .padding(.bottom, 16)

                    Text("Fenway, Boston, Massachussets")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.black.opacity(0.6))
                    VStack(alignment: .center) {
                        Text("Apartment Cleaning")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.black.opacity(0.8))
                    }
                    .padding(.top, 8)
                }
                
                Spacer()
                List(taskFlow) { task in
                    TaskItemView(task: task)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .padding(.horizontal, -16)
                
                RoundedButton(title: "Finish Job", action: {
                    // TODO: api call
                    showSuccessScreen.toggle()
                }, color: .black, textColor: .white)
            }
            .padding(16)
        }
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $showSuccessScreen, content: {
            WorkFlowSuccessScreen()
        })
    }
}

struct CircularButton: View {
    var image: String
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
                    .padding(8)
                Text(text)
                    .font(.system(size: 12))
                    .foregroundStyle(.black)
            }
            .frame(height: 80)
        }
        .shadow(color: .black.opacity(0.2), radius: 10, x: -5, y: -5)
    }
}


struct CardView1: View {
    let task: TaskItem
    @State private var subtaskStatus: [Bool]
    
    init(task: TaskItem) {
        self.task = task
        self._subtaskStatus = State(initialValue: Array(repeating: false, count: task.subtasks.count))
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.white)
            .overlay(
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.system(.title2, design: .rounded).weight(.bold))
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .foregroundColor(Color.black.opacity(0.9))
                        .lineLimit(2)
                    Text(task.description)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .padding(.horizontal, 16)
                        .foregroundColor(Color.black.opacity(0.3))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(task.subtasks.indices, id: \.self) { index in
                            SubtaskView(subtask: task.subtasks[index], isChecked: $subtaskStatus[index])
                                .padding(.horizontal, 16)
                                .padding(.bottom, 16)
                                .foregroundColor(.black.opacity(0.8))
                                .multilineTextAlignment(.leading)
                                .onTapGesture {
                                    subtaskStatus[index].toggle()
                                }
                        }
                    }
                    .padding(.top, 4)
                    
                    RoundedButton(title: "📸 Verify Task", action: {}, color: .black, textColor: .white)
                        .padding(.horizontal, 16)
                }
            )
            .frame(height: 500)
            .cornerRadius(10)
            .padding(1)
            .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 2)
            .padding(20)
    }
}

struct SubtaskView: View {
    let subtask: String
    @Binding var isChecked: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(isChecked ? .green : .black)
                .scaleEffect(isChecked ? 0.9 : 1)
                .padding(.trailing, 8)
            
            Text(subtask)
                .font(.system(.body).weight(.regular))
                .strikethrough(isChecked, color: .black)
            
            Spacer()
        }
    }
}


#Preview {
    WorkFlowView()
}


//Color(hex: "#00E676")
struct TaskItemView: View {
    let task: TaskItem
    @State private var showSubtasks = false
    @State private var subtaskStatus: [Bool]
    @State private var selectedImages: [UIImage?] = [nil, nil, nil]
    @State private var selectedImageIndex = 0
    @State private var isImagePickerPresented = false
    init(task: TaskItem) {
        self.task = task
        self._subtaskStatus = State(initialValue: Array(repeating: false, count: task.subtasks.count))
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
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color(hex: "#00E676"))
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(Color(hex: "#00E676").opacity(0.2))
                        )
                } else {
                    Text("In progress")
                        .font(.system(size: 12, weight: .regular))
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
                Text(task.title)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: showSubtasks ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                    .foregroundColor(.black.opacity(0.8))
                    .onTapGesture {
                        showSubtasks.toggle()
                    }
            }
            Text(task.description)
                .foregroundColor(.secondary)
                .font(.subheadline)
            
            if showSubtasks {
                ForEach(task.subtasks.indices, id: \.self) { index in
                    SubtaskView(subtask: task.subtasks[index], isChecked: $subtaskStatus[index])
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
                                }
                                else {
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
                    Text("Select atleast one image for verification of the completed task!")
                        .lineLimit(2, reservesSpace: true)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    if selectedImages.contains { $0 != nil } {
                        RoundedButton(title: "Submit verification images", action: {
                            showSubtasks.toggle()
                        }, color: .black, textColor: .white)
                    }
                }
            }
            HStack {
                Image(systemName: "list.clipboard")
                    .resizable()
                    .frame(width: 12, height: 16)
                    .foregroundStyle(Color(hex: AppUserInterface.Colors.appPrimaryBlue))
                Text("\(task.subtasks.count) Sub-Task")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.gray)
            }
        }
    }
}
