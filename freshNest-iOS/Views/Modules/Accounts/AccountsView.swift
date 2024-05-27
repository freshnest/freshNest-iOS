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
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                VStack(spacing: 24) {
                    ZStack {
                        Spacer()
                        Text("Account")
                            .font(.system(size: 28, weight: .bold))
                            .accessibility(addTraits: .isHeader)
                            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        Spacer()
                    }
                    VStack(spacing: 16) {
                        Image("profile")
                            .resizable()
                            .frame(width: 70, height: 70)
                        Text("Cheyenne Newstead")
                            .font(.system(size: 25, weight: .bold))
                    }
                    
                    
                    VStack {
                        SettingsRowView(title: "Edit Profile")
                            .padding(4)
                        SettingsRowView(title: "Edit Job Radius")
                            .padding(4)
                        SettingsRowView(title: "Contact")
                            .padding(4)
                    }
                    
                    Spacer()
                    VStack(spacing: 16){
                        Button(action: {
                            if let url = URL(string: self.emergencyNumber), UIApplication.shared.canOpenURL(url) {
                                           UIApplication.shared.open(url)
                                       }
                        }) {
                            Text("Safety")
                                .font(.headline)
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
                                    .font(.headline)
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
                                    // logout API CALL
                                    showOnboarding = true
                                }
                            }
                        }
                    }
                }
            }
            .padding(16)
        }
        .fullScreenCover(isPresented: $showOnboarding, content: {
            SignUpView(isBackButtonHidden: true)
        })
    }
}

#Preview {
    AccountsView()
}
