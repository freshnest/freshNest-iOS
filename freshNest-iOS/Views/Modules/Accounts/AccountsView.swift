//
//  AccountsView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct AccountsView: View {
    @Namespace var animation
    @GestureState var isDetectingLongPress = false
    @State var completedLongPress = false
    @State var showOnboarding = false
    let emergencyNumber = "tel://911"
    @AppStorage("notification") var notificationStatus : Bool = false
    @AppStorage("isAuthenticated") var isAuthenticated = false
    @EnvironmentObject var supabaseClient: SupabaseManager
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 1)
            .updating($isDetectingLongPress) {
                currentState, gestureState,
                _ in
                gestureState = currentState
            }
            .onEnded { finished in
                self.completedLongPress = finished
            }
    }
    
    @State var showVacationModeView = false
    @State var showWorkingHoursView = false
    @State var showNotificationsView = false
    @State var showEditJobRadiusView = false
    @State var showEditProfileView = false
    @State var showSupportItems = false
    @State var showEditImageView = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 24) {
                    ZStack(alignment: .leading) {
                        Spacer()
                        Text("Account")
                            .font(.cascaded(ofSize: .h28, weight: .bold))
                            .accessibility(addTraits: .isHeader)
                            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        Spacer()
                    }
                    
                    AccountUserInfoCell(action: {showEditImageView.toggle()})
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            VStack(spacing: 5) {
                                Text("Basic")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.cascaded(ofSize: .h18, weight: .bold))
                                    .padding(.vertical, 16)
                                VStack(spacing: 16) {
                                    SettingsRowView(systemImage: "person.crop.circle", title: "Edit Profile", action: { showEditProfileView.toggle() })
                                    Divider()
                                    SettingsRowView(systemImage: "location.circle", title: "Edit Job Radius", action: { showEditJobRadiusView.toggle() }, optionalText: "\(supabaseClient.userProfile?.jobRadius ?? "") miles")
                                    Divider()
                                }
                            }
                            VStack(spacing: 5) {
                                Text("Communications")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.cascaded(ofSize: .h18, weight: .bold))
                                    .padding(.vertical, 16)
                                VStack(spacing: 16) {
                                    SettingsRowView(systemImage: "bell.circle", title: "Notification", action: { showNotificationsView.toggle() }, optionalText: notificationStatus  ? "On" : "Off")
                                    Divider()
                                }
                            }
                            VStack(spacing: 5) {
                                Text("Availability")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.cascaded(ofSize: .h18, weight: .bold))
                                    .padding(.vertical, 16)
                                VStack(spacing: 16) {
                                    SettingsRowView(systemImage: "clock", title: "Working Hours", action: { showWorkingHoursView.toggle() })
                                    Divider()
                                    SettingsRowView(systemImage: "airplane.circle", title: "Vacation Mode", action: { showVacationModeView.toggle() }, optionalText: supabaseClient.userProfile?.vacationMode ?? false ? "On" : "Off")
                                    Divider()
                                }
                            }
                            VStack(spacing: 5) {
                                Text("Advanced")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.cascaded(ofSize: .h18, weight: .bold))
                                    .padding(.vertical, 16)
                                VStack(spacing: 16) {
                                    SettingsRowView(systemImage: "doc.text", title: "Tax Information")
                                    Divider()
                                    SettingsRowView(systemImage: "globe", title: "App Language", optionalText: "English")
                                    Divider()
                                    SettingsRowView(systemImage: "questionmark.circle", title: "Support", action: { showSupportItems.toggle() })
                                    Divider()
                                }
                            }
                            VStack(spacing: 5) {
                                Text("Others")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.cascaded(ofSize: .h18, weight: .bold))
                                    .padding(.vertical, 16)
                                VStack(spacing: 16) {
                                    SettingsRowView(systemImage: "star.circle", title: "Reviews")
                                    Divider()
                                    SettingsRowView(systemImage: "checkmark.shield", title: "Background check", optionalText: "Unverified")
                                    Divider()
                                }
                            }
                            VStack(spacing: 5) {
                                Text("Application")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.cascaded(ofSize: .h18, weight: .bold))
                                    .padding(.vertical, 16)
                                VStack(spacing: 16) {
                                    SettingsRowView(systemImage: "info.circle", title: "About Us")
                                    Divider()
                                    SettingsRowView(systemImage: "lock.shield", title: "Privacy Policy")
                                    Divider()
                                }
                            }
                        }
                        
                        VStack(spacing: 16){
                            Button(action: {
                                if let url = URL(string: self.emergencyNumber), UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Text("Safety")
                                    .font(.cascaded(ofSize: .h20, weight: .bold))
                                    .foregroundColor(.blue)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(16)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(/*Color(hex: "#FF6961").opacity(0.1)*/.clear)
                                    }
                            }
                            
                            GeometryReader { proxy in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(/*Color(hex: "#FF6961").opacity(0.1)*/.clear)
                                        .frame(width: proxy.size.width)
                                    
                                    Rectangle()
                                        .fill(Color(hex: /*PastelColor.redVibrant.hexCode*/"#FF6961"))
                                        .frame(width: proxy.size.width, height: 100)
                                        .offset(x: completedLongPress ? 0 : (isDetectingLongPress ? 0 : -(proxy.size.width)))
                                        .animation(.easeInOut(duration: 1), value: isDetectingLongPress)
                                    
                                    Text("Logout")
                                        .font(.cascaded(ofSize: .h20, weight: .bold))
                                        .foregroundColor(isDetectingLongPress ? .white : .red)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.black.opacity(0.05))
                                        .cornerRadius(16)
                                }
                                .frame(height: proxy.size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                            }
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 16)
                            .gesture(
                                LongPressGesture(minimumDuration: 1)
                                    .updating(
                                        $isDetectingLongPress,
                                        body: { currentState, state, _ in
                                            state = currentState
                                        }
                                    )
                                    .onEnded { _ in
                                        self.completedLongPress.toggle()
                                    }
                            )
                            .onChange(of: completedLongPress) { _ in
                                if completedLongPress {
                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        Task {
                                            do {
                                                try await supabaseClient.signOut()
                                                isAuthenticated = false
                                                let newAuth = SupabaseManager()
                                                let newtabBarManager = TabBarManager()
                                                if let window = UIApplication.shared.windows.first {
                                                    window.rootViewController = UIHostingController(rootView:
                                                                                                        OnboardingView()
                                                        .environmentObject(newAuth)
                                                        .environmentObject(newtabBarManager)
                                                        .preferredColorScheme(.light)
                                                    )
                                                    window.makeKeyAndVisible()
                                                }
                                            } catch {
                                                print("Error Logging out: \(error)")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 40)
                    }
                }
            }
            .padding(16)
        }
        .fullScreenCover(isPresented: $showVacationModeView, content: {
            VacationModeView()
        })
        .fullScreenCover(isPresented: $showNotificationsView, content: {
            SettingsNotificationView()
        })
        .fullScreenCover(isPresented: $showEditProfileView, content: {
            EditProfileView()
        })
        .fullScreenCover(isPresented: $showWorkingHoursView, content: {
            WorkingHoursView()
        })
        .fullScreenCover(isPresented: $showEditJobRadiusView, content: {
            EditJobRadiusView()
        })
        .sheet(isPresented: $showEditImageView) {
            EditImageView() {
                showEditImageView.toggle()
            }
            .presentationDetents([.medium])
        }
        .sheet(isPresented: $showSupportItems, content: {
            SupportItemsView()
                .presentationDetents([.large])
        })
    }
}

#Preview {
    AccountsView()
}
