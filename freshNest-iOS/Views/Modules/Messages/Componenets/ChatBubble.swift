//
//  ChatBubble.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 28/06/24.
//

import SwiftUI

struct ChatBubble: View {
    let message: Message
    
    init(message: Message) {
        self.message = message
    }
    
    var body: some View {
        HStack {
            if message.direction == .right {
                Spacer()
            }
            
            VStack {
                if let text = message.text {
                    Text(text)
                        .padding(.all, 12)
//                        .padding(.trailing, 8)
                        .foregroundColor((message.direction == .right) ? .white : .black)
                        .background((message.direction == .right) ? .black : .black.opacity(0.1))
                        .clipShape(ChatBubbleShape(direction: (message.direction == .right) ? .right : .left))
                }
            }
            
            if message.direction == .left {
                Spacer()
            }
        }
        .padding([(message.direction == .left) ? .leading : .trailing, .top, .bottom], 8)
        .padding([(message.direction == .right) ? .leading : .trailing, .top, .bottom], 8)
    }
}
