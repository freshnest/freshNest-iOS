//
//  MessagesMainView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/05/24.
//

import SwiftUI

struct InboxMainView: View {
    @State private var selectedTab: Switch = .inbox
    @EnvironmentObject var supabaseClient: SupabaseManager
    @State private var connectedPeople: [MessageCellData] = []
    @State private var notifications: [NotificationCellData] = []
    @State private var fetchedMessageFromChannel: [Message] = []
    @State private var navigateToChatView = false
    @State private var messageTitle = ""
    @State private var recipient = ""
    enum Switch {
        case inbox
        case notification
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ZStack {
                    Spacer()
                    Text("Inbox")
                        .font(.cascaded(ofSize: .h28, weight: .bold))
                        .accessibility(addTraits: .isHeader)
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    Spacer()
                }
                
                HStack {
                    SwitchView(selectedTab: $selectedTab)
                    Spacer()
                }
                
                if selectedTab == .inbox {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            if connectedPeople.isEmpty {
                                EmptyStateView(message: "You don't have any messages currently.", imageText: "📨")
                                    .padding(.top, 16)
                            } else {
                                ForEach(connectedPeople, id: \.self) { messageItem in
                                    NotificationCell(image: "", name: messageItem.firstName, message: messageItem.message, bookingStatus: messageItem.bookingStatus)
                                    .onTapGesture {
                                        Task {
                                            do {
                                                messageTitle = messageItem.firstName
                                                let currentUser = try await supabaseClient.supabase.auth.session.user
                                                let response: [MessageData] = try await supabaseClient
                                                    .supabase
                                                    .rpc("get_thread", params: ["u_id" : currentUser.id.uuidString])
                                                    .execute()
                                                    .value
                                                recipient = messageItem.hostUserID.uuidString
                                                fetchedMessageFromChannel = response.map { data in
                                                    Message(text: data.text, direction: data.direction ? .left : .right)
                                                }
                                                navigateToChatView = true
                                            } catch {
                                                print(error)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    NotificationItemCell()
                        .padding(16)
                }
                Spacer()
            }
            .padding(16)
            .onAppear {
                Task {
                    do {
                        let messageList: [MessageCellData] = try await supabaseClient
                            .supabase
                            .rpc("fetch_connected_hosts")
                            .execute()
                            .value
                        connectedPeople = messageList
                    } catch {
                        print(error)
                    }
                }
            }
            .fullScreenCover(isPresented: $navigateToChatView) {
                ChatView(messages: $fetchedMessageFromChannel, pageTitle: $messageTitle, recipient: $recipient)
            }
        }
    }
}

#Preview {
    InboxMainView()
//    NotificationItemCell()
    //    NotificationEmptyViewCell()
    //    NotificationCell()
}

struct NotificationItemCell : View {
//    var image: String
//    var date: String
//    var message: String
    var body: some View {
        HStack {
            Image(systemName: "calendar.badge.checkmark")
                .scaledToFit()
                .foregroundColor(.white)
                .background(
                    Circle()
                        .fill(Color.purple)
                        .frame(width: 60, height: 60)
                )
                .padding(.trailing, 24) 
            VStack(alignment: .leading) {
                Text("You have 5 upcoming cleaning bookings scheduled!")
                    .font(.cascaded(ofSize: .h18, weight: .medium))
                Text("May 12, 2024")
                    .font(.cascaded(ofSize: .h14, weight: .regular))
            }
        }
    }
}

struct SwitchView: View {
    @Binding var selectedTab: InboxMainView.Switch
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Button(action: {
                    self.selectedTab = .inbox
                }) {
                    Text("Messages")
                        .padding(.vertical, 10)
                        .background(.clear)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .background(
                    ZStack(alignment: .top) {
                        withAnimation(.easeInOut(duration: 0.3)){
                            RoundedRectangle(cornerRadius: 2)
                                .frame(width: self.selectedTab == .inbox  ? 80 : 0, height: 4)
                                .offset(y: 20)
                        }
                    }
                )
                Button(action: {
                    self.selectedTab = .notification
                }) {
                    Text("Notifications")
                        .padding(.vertical, 10)
                        .background(.clear)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .background(
                    ZStack(alignment: .top) {
                        withAnimation(.easeInOut(duration: 0.3)){
                            RoundedRectangle(cornerRadius: 2)
                                .frame(width: self.selectedTab == .notification  ? 100 : 0, height: 4)
                                .offset(y: 20)
                        }
                    }
                )
            }
        }
    }
}

struct NotificationCellData: Identifiable {
    var id = UUID()
    var image: String
    var name: String
    var message: String
    var bookingStatus: String
}

struct MessageCellData: Codable, Hashable {
    
    static func == (lhs: MessageCellData, rhs: MessageCellData) -> Bool {
        return lhs.createdAt == rhs.createdAt
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(createdAt)
    }
    var hostUserID: UUID
    var firstName: String
    var lastName: String
    var bookingStatus: String
    var message: String
    var createdAt: Date
    enum CodingKeys: String, CodingKey {
        case hostUserID = "host_user_id"
        case firstName = "host_first_name"
        case lastName = "host_last_name"
        case bookingStatus = "status"
        case message = "text"
        case createdAt = "created_at"
    }
}


struct MessageData: Codable {
    var text: String
    var direction: Bool
}

struct NotificationCell: View {
    var image: String
    var name: String
    var message: String
    var bookingStatus: String
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image("profilePlaceholderImage")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.black.opacity(0.05), lineWidth: 1)
                    )
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.cascaded(ofSize: .h16, weight: .regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Text(message)
                        .font(.cascaded(ofSize: .h18, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Text(bookingStatus)
                        .font(.cascaded(ofSize: .h16, weight: .regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
            }
            Divider()
        }
    }
}

struct NotificationEmptyViewCell : View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "bell")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundStyle(.black)
            
            Text("No Notifications yet")
                .font(.cascaded(ofSize: .h16, weight: .medium))
            
            Text("You've got a blank slate (for now). We'll let you know when the update arrives")
                .font(.cascaded(ofSize: .h16, weight: .regular))
                .multilineTextAlignment(.center)
        }
    }
}
