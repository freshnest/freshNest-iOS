//
//  SettingsNotificationView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct SettingsNotificationView: View {
    @Namespace var animation
    @AppStorage("notification") var notificationStatus : Bool = false
    @AppStorage("showNotifications") var showNotifications : Bool = false
    var center = UNUserNotificationCenter.current()
    var body: some View {
        VStack(spacing: 24) {
            HeaderCell(headerTitle: "Notifications")
            
            VStack(alignment: .leading, spacing: 8) {
                
                ToggleRow(
                    text: "Enable Notification",
                    bool: $notificationStatus,
                    id: 1)
                
                Text(
                    "Activate this option to receive notifications/reminders for your scheduled jobs."
                )
                .font(.cascaded(ofSize: .h14, weight: .regular))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                .foregroundColor(Color.black.opacity(0.5))
                .multilineTextAlignment(.leading)
            }
            Spacer()
        }
        .padding(16)
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    func ToggleRow(text: String, bool: Binding<Bool>, id: Int) -> some View {
        HStack {
            Text(text)
                .font(.cascaded(ofSize: .h18, weight: .regular))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                .foregroundColor(Color.black.opacity(0.7))
            
            Spacer()
            
            ZStack(alignment: showNotifications ? .trailing : .leading) {
                Capsule()
                    .frame(width: 42, height: 28)
                    .foregroundColor(showNotifications ? .green : .gray.opacity(0.8))
                
                Circle()
                    .foregroundColor(Color.white)
                    .padding(2)
                    .frame(width: 28, height: 28)
                    .matchedGeometryEffect(id: "toggle\(id)", in: animation)
            }
            .onTapGesture {
                if showNotifications {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        center.removeAllPendingNotificationRequests()
                        showNotifications.toggle()
                        notificationStatus = showNotifications
                    }
                } else {
                    center.getNotificationSettings { settings in
                        if settings.authorizationStatus == .notDetermined {
                            center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        showNotifications.toggle()
                                        notificationStatus = showNotifications
                                    }
                                } else if let error = error {
                                    print(error.localizedDescription)
                                    notificationStatus = false
                                }
                            }
                        } else if settings.authorizationStatus == .denied {
                            notificationStatus = false
                            DispatchQueue.main.async {
                                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(settingsURL)
                                }
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showNotifications.toggle()
                                if showNotifications {
                                    notificationStatus = showNotifications
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

#Preview {
    SettingsNotificationView()
}
