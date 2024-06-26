//
//  CleanersModel.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 06/06/24.
//

import Foundation

struct CleanersModel: Codable, Identifiable, Hashable {
    var id: UUID?
    var createdAt: Date?
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var averageRating: Double?
    var backgroundCheck: Bool?
    var longitude: Double?
    var latitude: Double?
    var email: String?
    var jobRadius: String?
    var vacationMode: Bool?
    var workingHours: [String: TimeRange]?
    
    enum CodingKeys: String, CodingKey {
        case id, longitude, latitude, email
        case createdAt = "created_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "number_phone"
        case averageRating = "average_rating"
        case backgroundCheck = "background_check"
        case jobRadius = "job_radius"
        case vacationMode = "vacation_mode"
        case workingHours = "working_hours"
    }
    
    static func == (lhs: CleanersModel, rhs: CleanersModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.createdAt == rhs.createdAt &&
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.phoneNumber == rhs.phoneNumber &&
        lhs.averageRating == rhs.averageRating &&
        lhs.backgroundCheck == rhs.backgroundCheck &&
        lhs.longitude == rhs.longitude &&
        lhs.latitude == rhs.latitude &&
        lhs.email == rhs.email &&
        lhs.jobRadius == rhs.jobRadius &&
        lhs.vacationMode == rhs.vacationMode &&
        lhs.workingHours == rhs.workingHours
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(createdAt)
        hasher.combine(firstName)
        hasher.combine(lastName)
        hasher.combine(phoneNumber)
        hasher.combine(averageRating)
        hasher.combine(backgroundCheck)
        hasher.combine(longitude)
        hasher.combine(latitude)
        hasher.combine(email)
        hasher.combine(jobRadius)
        hasher.combine(vacationMode)
        if let workingHours = workingHours {
            for (key, value) in workingHours {
                hasher.combine(key)
                hasher.combine(value)
            }
        }
    }
}

struct TimeRange: Codable, Equatable, Hashable {
    var from: String
    var to: String

    init(from: String, to: String) {
        self.from = from
        self.to = to
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        from = try container.decode(String.self, forKey: .from)
        to = try container.decode(String.self, forKey: .to)
    }

    private enum CodingKeys: String, CodingKey {
        case from
        case to
    }
}

