//
//  ChatView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 28/06/24.
//

import SwiftUI
import Realtime

struct ChatView: View {
    @EnvironmentObject var supabaseClient: SupabaseManager
    @State private var newMessageText = ""
    @Binding var messages: [Message]
    @Binding var pageTitle: String
    @Binding var recipient: String
    @Environment(\.presentationMode) var presentationMode
    @State private var scrollToBottom = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea(.all)
                VStack {
                    VStack(spacing: 0) {
                        ZStack(alignment: .center) {
                            HStack {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "arrow.left")
                                        .font(.system(.title2, design: .rounded).weight(.semibold))
                                        .foregroundColor(Color.black)
                                }
                                Spacer()
                            }
                            Text(pageTitle)
                                .font(.cascaded(ofSize: .h28, weight: .bold))
                                .accessibility(addTraits: .isHeader)
                                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        }
                        
                        Divider()
                            .padding(.horizontal, -16)
                            .padding(.top, 16)
                    }
                    .frame(height: 40)
                    
                    ScrollViewReader { proxy in
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 0) {
                                ForEach(messages.indices, id: \.self) { index in
                                    ChatBubble(message: messages[index])
                                        .id(index)
                                }
                            }
                        }
                        .onChange(of: scrollToBottom) { _ in
                            withAnimation {
                                proxy.scrollTo(messages.count - 1, anchor: .bottom)
                            }
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation {
                                    proxy.scrollTo(messages.count - 1, anchor: .bottom)
                                }
                            }
                        }
                    }
                    HStack {
                        CustomChatTextField(text: $newMessageText,
                                            actionForSend: {
                            if !newMessageText.isEmpty {
                                Task {
                                    do {
                                        messages = try await supabaseClient.sendMessageAndUpdateThread(
                                            recipient: recipient,
                                            messageText: newMessageText
                                        )
                                        newMessageText = ""
                                        scrollToBottom = true
                                    } catch {
                                        print("Error sending message: \(error)")
                                    }
                                }
                            }
                        })
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                .background(.ultraThinMaterial)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
