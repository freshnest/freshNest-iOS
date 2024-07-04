//
//  SupabaseManager.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 06/06/24.
//

import SwiftUI
import Supabase

enum Table {
    static let cleaners = "cleaners"
    static let hosts = "hosts"
    static let messages = "messages"
    static let propertyInfo = "property_info"
    static let requestedCleanings = "requested_cleanings"
    static let tasklist = "tasklist"
}

@MainActor
final class SupabaseManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var accessToken = ""
    @Published var refreshToken = ""
    @Published var userID = ""
    @Published var userProfile: CleanersModel?
    @Published var availableJobsArray: [AvailableJobModel] = []
    @Published var scheduledJobsArray: [ScheduledJobsModel] = []
    @Published var scheduledJobsCount = 0
    @Published var selectedImage: UIImage? = nil
    let supabase = SupabaseClient(supabaseURL: URL(string: "https://cundjcwzibpwiiuxitul.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN1bmRqY3d6aWJwd2lpdXhpdHVsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM1MzU2MjQsImV4cCI6MjAyOTExMTYyNH0.AoiSo5wdnV5A6WVPwaEIk9W1r_-6ZdMUoE5kbEXqfKI")
    
    func signUp(email: String, password: String, firstName: String, lastName: String) async {
        do {
            let response = try await supabase.auth.signUp(email: email, password: password, data: [
                "first_name": .string(firstName),
                "last_name": .string(lastName),
                "sub": .string("cleaner")
              ])
            print("Sign-up successful: \(response)")
        
            accessToken = response.session?.accessToken ?? ""
            refreshToken = response.session?.refreshToken ?? ""
            userID = response.session?.user.id.uuidString ?? ""
            
            isAuthenticated = true
        } catch {
            print("Sign-up error: \(error.localizedDescription)")
            isAuthenticated = false
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            let session = try await supabase.auth.signIn(email: email, password: password)
            print("Sign-in successful: \(session)")
            
            accessToken = session.accessToken
            refreshToken = session.refreshToken
            userID = session.user.id.uuidString
            
            isAuthenticated = true
        } catch {
            print("Sign-in error: \(error.localizedDescription)")
            isAuthenticated = false
        }
    }
    
    func isUserAuthenticated() async {
        do {
            _ = try await supabase.auth.session.user
            isAuthenticated = true
        } catch {
            isAuthenticated = false
        }
        print("User Authentication Status: \(isAuthenticated)")
    }
    
    func signOut() async throws {
        do {
            try await supabase.auth.signOut()
            isAuthenticated = false
            print("Sign-out successful")
        } catch {
            print("Sign-out error: \(error.localizedDescription)")
        }
    }
    
    func fetchUserData() {
        Task{
            do {
                let currentUser = try await supabase.auth.session.user
                
                let profile: [CleanersModel] = try await supabase
                    .from("cleaners")
                    .select()
                    .eq("id", value: currentUser.id)
                    .execute()
                    .value
                
                userProfile = profile.first ?? CleanersModel()
                // MARK: PRINT PROFILE
                //            print("Response \(profile)")
            } catch {
                print("Error fetching user profile: \(error)")
            }
        }
    }
    
    func fetchAvailableJobs(completion: @escaping (Bool) -> Void) {
        Task{
            do {
                let response = try await supabase.rpc("fetch_available_jobs").execute().data
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode([AvailableJobModel].self, from: response)
                    DispatchQueue.main.async {
                        self.availableJobsArray = decodedData
                        completion(true)
                        print("New data fetched successfully for available jobs.")
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            } catch {
                print("Error: \(error)")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func fetchAvailableJobsWithoutLoader() {
        Task{
            do {
                let response = try await supabase.rpc("fetch_available_jobs").execute().data
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode([AvailableJobModel].self, from: response)
                    availableJobsArray = decodedData
                    print(decodedData[0])
                } catch {
                    print(error.localizedDescription)
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func fetchScheduledJobs() {
        Task{
            do {
                let currentUser = try await supabase.auth.session.user
                let response = try await supabase.rpc("fetch_scheduled_jobs").execute().data
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode([ScheduledJobsModel].self, from: response)
                    scheduledJobsArray = decodedData
                    scheduledJobsCount = scheduledJobsArray.count
                    print(decodedData[0])
                } catch {
                    print(error.localizedDescription)
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func matchWithJob(jobID: String){
        Task {
            do {
                let currentUser = try await supabase.auth.session.user
                let response = try await supabase.rpc("accept_job", params: ["j_id": UUID(uuidString: jobID)]).execute()
                print("Match Response: ",response.status)
                fetchScheduledJobs()
                fetchAvailableJobsWithoutLoader()
            } catch {
                print("Failed to update phone: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPropertyData(from propertyID: String) async throws -> PropertyInfoModel? {
        do {
            let currentUser = try await supabase.auth.session.user
            let property: [PropertyInfoModel] = try await supabase
                .from(Table.propertyInfo)
                .select()
                .eq("property_id", value: propertyID)
                .execute()
                .value
            if let data = property.first {
                let propertyInfo = data
                print(propertyInfo)
                return propertyInfo
            } else {
                return nil
            }
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    func downloadImage(path: String) async throws -> UIImage {
        let data = try await supabase.storage.from("avatars").download(path: path)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "ImageConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to image"])
        }
        return image
    }
    
    func sendMessageAndUpdateThread(recipient: String, messageText: String) async throws -> [Message] {
        do {
            let currentUser = try await supabase.auth.session.user
            let item = InsertMessageCellData(
                userID: UUID(uuidString: recipient) ?? UUID(),
                message: messageText,
                sentBy: UUID(uuidString: currentUser.id.uuidString) ?? UUID()
            )
            let insertResponse = try await supabase.from(Table.messages).insert(item).execute()
            print("Insert response:", insertResponse)
            let threadResponse: [MessageData] = try await supabase
                .rpc("get_thread", params: ["u_id" : currentUser.id.uuidString])
                .execute()
                .value
            let updatedMessages = threadResponse.map { data in
                Message(text: data.text, direction: data.direction ? .left : .right)
            }
            
            return updatedMessages
        } catch {
            print("Error sending message and updating thread: \(error)")
            throw error
        }
    }
}
