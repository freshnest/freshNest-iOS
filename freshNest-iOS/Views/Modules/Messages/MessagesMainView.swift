//
//  MessagesMainView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/05/24.
//

import SwiftUI

struct InboxMainView: View {
    @State private var selectedTab: Switch = .inbox
    
    enum Switch {
        case inbox
        case notification
    }
    var body: some View {
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
                        ForEach(notifications, id: \.id) { notification in
                            NotificationCell(image: notification.image, name: notification.name, message: notification.message, bookingStatus: notification.bookingStatus)
                        }
                    }
                }
            } else {
//                VStack(alignment: .center) {
//                    NotificationEmptyViewCell()
//                        .padding(.top, 90)
//                }
//                .frame(maxWidth: .infinity)
                NotificationItemCell()
                    .padding(16)
            }
           Spacer()
        }
        .padding(16)
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
                    Text(message)
                        .font(.cascaded(ofSize: .h18, weight: .medium))
                    Text(bookingStatus)
                        .font(.cascaded(ofSize: .h16, weight: .regular))
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
