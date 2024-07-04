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

struct ChatBubbleShape: Shape {
    enum Direction {
        case left
        case right
    }
    
    let direction: Direction
    
    func path(in rect: CGRect) -> Path {
        return (direction == .left) ? getLeftBubblePath(in: rect) : getRightBubblePath(in: rect)
    }
    
    private func getLeftBubblePath(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let path = Path { p in
            p.move(to: CGPoint(x: 25, y: height))
            p.addLine(to: CGPoint(x: width - 20, y: height))
            p.addCurve(to: CGPoint(x: width, y: height - 20),
                       control1: CGPoint(x: width - 8, y: height),
                       control2: CGPoint(x: width, y: height - 8))
            p.addLine(to: CGPoint(x: width, y: 20))
            p.addCurve(to: CGPoint(x: width - 20, y: 0),
                       control1: CGPoint(x: width, y: 8),
                       control2: CGPoint(x: width - 8, y: 0))
            p.addLine(to: CGPoint(x: 21, y: 0))
            p.addCurve(to: CGPoint(x: 4, y: 20),
                       control1: CGPoint(x: 12, y: 0),
                       control2: CGPoint(x: 4, y: 8))
            p.addLine(to: CGPoint(x: 4, y: height - 11))
            p.addCurve(to: CGPoint(x: 0, y: height),
                       control1: CGPoint(x: 4, y: height - 1),
                       control2: CGPoint(x: 0, y: height))
            p.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
            p.addCurve(to: CGPoint(x: 11.0, y: height - 4.0),
                       control1: CGPoint(x: 4.0, y: height + 0.5),
                       control2: CGPoint(x: 8, y: height - 1))
            p.addCurve(to: CGPoint(x: 25, y: height),
                       control1: CGPoint(x: 16, y: height),
                       control2: CGPoint(x: 20, y: height))
            
        }
        return path
    }
    
    private func getRightBubblePath(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let path = Path { p in
            p.move(to: CGPoint(x: 25, y: height))
            p.addLine(to: CGPoint(x:  20, y: height))
            p.addCurve(to: CGPoint(x: 0, y: height - 20),
                       control1: CGPoint(x: 8, y: height),
                       control2: CGPoint(x: 0, y: height - 8))
            p.addLine(to: CGPoint(x: 0, y: 20))
            p.addCurve(to: CGPoint(x: 20, y: 0),
                       control1: CGPoint(x: 0, y: 8),
                       control2: CGPoint(x: 8, y: 0))
            p.addLine(to: CGPoint(x: width - 21, y: 0))
            p.addCurve(to: CGPoint(x: width - 4, y: 20),
                       control1: CGPoint(x: width - 12, y: 0),
                       control2: CGPoint(x: width - 4, y: 8))
            p.addLine(to: CGPoint(x: width - 4, y: height - 11))
            p.addCurve(to: CGPoint(x: width, y: height),
                       control1: CGPoint(x: width - 4, y: height - 1),
                       control2: CGPoint(x: width, y: height))
            p.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
            p.addCurve(to: CGPoint(x: width - 11, y: height - 4),
                       control1: CGPoint(x: width - 4, y: height + 0.5),
                       control2: CGPoint(x: width - 8, y: height - 1))
            p.addCurve(to: CGPoint(x: width - 25, y: height),
                       control1: CGPoint(x: width - 16, y: height),
                       control2: CGPoint(x: width - 20, y: height))
            
        }
        return path
    }
}
