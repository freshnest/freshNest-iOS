//
//  EditImageView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 26/06/24.
//

import SwiftUI
import Storage

struct EditImageView: View {
    @State private var isImagePickerPresented: Bool = false
    @State private var isLoading: Bool = false
    @EnvironmentObject var supabaseClient: SupabaseManager
    @Environment(\.presentationMode) var presentationMode
    var action: () -> Void
    var body: some View {
        VStack(spacing: 24) {
            ZStack(alignment: .center) {
                Text("Edit Profile Image")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .accessibility(addTraits: .isHeader)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            }
            Spacer()
            VStack(spacing: 32) {
                ZStack {
                    if let selectedImage = supabaseClient.selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.black.opacity(0.05), lineWidth: 1)
                            )
                            .overlay {
                                Image(systemName: "square.and.pencil")
                                    .frame(width: 24, height: 24)
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(.white)
                                            .stroke(Color.black.opacity(0.5), lineWidth: 1)
                                            .foregroundStyle(.white)
                                    )
                                    .offset(x: 40, y: 40)
                            }
                            .onTapGesture {
                                print("Profile Picture Edit Button clicked!")
                                // open ImagePicker
                                isImagePickerPresented = true
                            }
                    } else {
                        Image("profilePlaceholderImage")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.black.opacity(0.05), lineWidth: 1)
                            )
                            .overlay {
                                Image(systemName: "square.and.pencil")
                                    .frame(width: 24, height: 24)
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(.white)
                                            .stroke(Color.black.opacity(0.5), lineWidth: 1)
                                            .foregroundStyle(.white)
                                    )
                                    .offset(x: 40, y: 40)
                            }
                            .onTapGesture {
                                print("Profile Picture Edit Button clicked!")
                                // open ImagePicker
                                isImagePickerPresented = true
                            }
                    }
                    
                }
                if !isLoading {
                    RoundedButton(title: "Save", action: saveImage, color: .black, textColor: .white)
                        .padding(.horizontal, 40)
                } else {
                    ProgressView()
                }
            }
            Spacer()
        }
        .padding(16)
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $supabaseClient.selectedImage)
        }
        .onAppear {
            Task {
                let currentUser = try await supabaseClient.supabase.auth.session.user
                let fileName = "\(currentUser.id).jpeg"
                supabaseClient.selectedImage = try await supabaseClient.downloadImage(path: fileName)
            }
        }
    }
    
    func saveImage() {
        isLoading = true
        guard let selectedImage = supabaseClient.selectedImage else { return }
        if let imageData = selectedImage.jpegData(compressionQuality: 0.1) {
            Task {
                do {
                    let currentUser = try await supabaseClient.supabase.auth.session.user
                    let fileName = "\(currentUser.id).jpeg"
                    
                    let response = try await supabaseClient
                        .supabase
                        .storage
                        .from("avatars")
                        .upload(path: "\(fileName)", file: imageData, options: FileOptions(contentType: "image/jpeg", upsert: true))
                    print(response)
                    supabaseClient.fetchUserData()
                    action()
                    isLoading = false
                } catch {
                    print("Failed to update profile image: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    EditImageView(action: {})
}
