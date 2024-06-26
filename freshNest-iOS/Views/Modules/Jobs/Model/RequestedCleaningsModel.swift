//
//  RequestedCleaningsModel.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 20/06/24.
//

import Foundation

struct RequestedCleaningsModel: Codable {
    var jobID: UUID?
    var createdAt: Date?
    var status: String?
    var assignedAt: Date?
    var payementRecievedAt: Date?
    var paymentStatus: String?
    var holdingMoneyReceived: String?
    var notes: String?
    var updatedAt: Date?
    var hostPhoneNumber: Int?
    var hostID: UUID?
    var cleanerID: UUID?
    var dateTime: Date?
    var cleanerLastName: String?
    var taskList: String?
    var cleanerFirstName: String?
    enum CodingKeys: String, CodingKey {
        case status, notes, taskList
        case jobID = "job_id"
        case createdAt = "created_at"
        case assignedAt = "assigned_at"
        case payementRecievedAt = "payment_recieved_at"
        case paymentStatus = "payment_status"
        case holdingMoneyReceived = "holding_money_recieved"
        case updatedAt = "updated_at"
        case hostPhoneNumber = "host_phone_number"
        case hostID = "host_id"
        case cleanerID = "cleaner_id"
        case dateTime = "date_time"
        case cleanerLastName = "cleaner_last_name"
        case cleanerFirstName = "cleaner_first_name"
    }
}
