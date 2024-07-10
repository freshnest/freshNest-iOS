//
//  PropertyInfoModel.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 22/06/24.
//

import Foundation

struct PropertyInfoModel: Codable {
    var propertyId: String?
    var createdAt: Date?
    var propertyType: String?
    var bedroomCount: Int?
    var isLaundryMachineAvailable: Bool?
    var isCleaningSuppliesAvailable: Bool?
    var updatedAt: Date?
    var hostId: UUID?
    var cleaningFee: String?
    var addressJSON: Address?
    var bathroomCount: Int?
    var propertyName: String?
    
    enum CodingKeys: String, CodingKey {
        case propertyId = "property_id"
        case createdAt = "created_at"
        case propertyType = "property_type"
        case bedroomCount = "property_bedrooms"
        case isLaundryMachineAvailable = "laundry_machine"
        case isCleaningSuppliesAvailable = "cleaning_supplies"
        case updatedAt = "updated_at"
        case hostId = "host_id"
        case cleaningFee = "cleaning_fee"
        case addressJSON = "address"
        case bathroomCount = "property_bathrooms"
        case propertyName = "property_name"
    }
}
