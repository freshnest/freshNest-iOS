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
