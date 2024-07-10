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
