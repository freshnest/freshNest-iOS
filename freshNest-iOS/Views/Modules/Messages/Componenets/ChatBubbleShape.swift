//
//  ChatBubbleShape.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

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
        let cornerRadius: CGFloat = 20
        let smallCornerRadius: CGFloat = 5
        
        let path = Path { p in
            // Top left corner
            p.move(to: CGPoint(x: cornerRadius, y: 0))
            
            // Top edge
            p.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
            
            // Top right corner
            p.addArc(center: CGPoint(x: width - cornerRadius, y: cornerRadius),
                     radius: cornerRadius,
                     startAngle: Angle(degrees: -90),
                     endAngle: Angle(degrees: 0),
                     clockwise: false)
            
            // Right edge
            p.addLine(to: CGPoint(x: width, y: height - cornerRadius))
            
            // Bottom right corner
            p.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius),
                     radius: cornerRadius,
                     startAngle: Angle(degrees: 0),
                     endAngle: Angle(degrees: 90),
                     clockwise: false)
            
            // Bottom edge
            p.addLine(to: CGPoint(x: smallCornerRadius, y: height))
            
            // Bottom left corner (less rounded)
            p.addArc(center: CGPoint(x: smallCornerRadius, y: height - smallCornerRadius),
                     radius: smallCornerRadius,
                     startAngle: Angle(degrees: 90),
                     endAngle: Angle(degrees: 180),
                     clockwise: false)
            
            // Left edge
            p.addLine(to: CGPoint(x: 0, y: cornerRadius))
            
            // Top left corner
            p.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                     radius: cornerRadius,
                     startAngle: Angle(degrees: 180),
                     endAngle: Angle(degrees: 270),
                     clockwise: false)
        }
        return path
    }
    
    private func getRightBubblePath(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let cornerRadius: CGFloat = 20
        let smallCornerRadius: CGFloat = 5
        
        let path = Path { p in
            // Top left corner
            p.move(to: CGPoint(x: cornerRadius, y: 0))
            
            // Top edge
            p.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
            
            // Top right corner
            p.addArc(center: CGPoint(x: width - cornerRadius, y: cornerRadius),
                     radius: cornerRadius,
                     startAngle: Angle(degrees: -90),
                     endAngle: Angle(degrees: 0),
                     clockwise: false)
            
            // Right edge
            p.addLine(to: CGPoint(x: width, y: height - smallCornerRadius))
            
            // Bottom right corner (less rounded)
            p.addArc(center: CGPoint(x: width - smallCornerRadius, y: height - smallCornerRadius),
                     radius: smallCornerRadius,
                     startAngle: Angle(degrees: 0),
                     endAngle: Angle(degrees: 90),
                     clockwise: false)
            
            // Bottom edge
            p.addLine(to: CGPoint(x: cornerRadius, y: height))
            
            // Bottom left corner
            p.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius),
                     radius: cornerRadius,
                     startAngle: Angle(degrees: 90),
                     endAngle: Angle(degrees: 180),
                     clockwise: false)
            
            // Left edge
            p.addLine(to: CGPoint(x: 0, y: cornerRadius))
            
            // Top left corner
            p.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                     radius: cornerRadius,
                     startAngle: Angle(degrees: 180),
                     endAngle: Angle(degrees: 270),
                     clockwise: false)
        }
        return path
    }
}
