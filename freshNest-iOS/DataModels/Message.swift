//
//  Message.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import Foundation

struct Message: Hashable {
    let text: String?
    let direction: ChatDirection
}

enum ChatDirection {
    case left
    case right
}

struct InsertMessageCellData: Codable {
    var userID: UUID
    var message: String
    var sentBy: UUID
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case message = "text"
        case sentBy = "sent_by"
    }
}

struct MessageData: Codable {
    var text: String
    var direction: Bool
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
