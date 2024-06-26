//
//  JobModel.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import Foundation

struct JobModel: Identifiable, Hashable {
    let id = UUID()
    var jobType: JobType
    var amount: String
    var workItems: String
    var timeToDestination: String
    var address: String
    var date: Date
    
    static func == (lhs: JobModel, rhs: JobModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum JobType {
    case scheduled
    case available
}


struct AvailableJobModel: Codable, Hashable {
    static func == (lhs: AvailableJobModel, rhs: AvailableJobModel) -> Bool {
        return lhs.jobID == rhs.jobID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(jobID)
    }
    
    var jobID: String?
    var createdAt: String?
    var addressJSON: Address?
    var propertyId: String?
    var bedroom: Int?
    var bathroom: Int?
    var price: String?
    enum CodingKeys: String, CodingKey {
        case jobID = "job_id"
        case createdAt = "created_at"
        case addressJSON = "address_json"
        case propertyId = "property_id"
        case bedroom, bathroom, price
    }
}

struct Address: Codable {
    var zip: String?
    var city: String?
    var state: String?
    var number: String?
    var street: String?
    var aptNumber: String?
    enum CodingKeys: String, CodingKey {
        case aptNumber = "apt_number"
        case zip, city, state, number, street
    }
}

struct ScheduledJobsModel: Codable, Hashable {
    static func == (lhs: ScheduledJobsModel, rhs: ScheduledJobsModel) -> Bool {
        return lhs.jobID == rhs.jobID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(jobID)
    }
    
    var jobID: String?
    var dateTime: String?
    var addressJSON: Address?
    var propertyId: String?
    var bedroom: Int?
    var bathroom: Int?
    var price: String?
    enum CodingKeys: String, CodingKey {
        case jobID = "job_id"
        case dateTime = "date_time"
        case addressJSON = "address_json"
        case propertyId = "property_id"
        case bedroom, bathroom, price
    }
}
