//
//  TaskListModel.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 25/06/24.
//

import Foundation

struct TaskListModel: Codable {
    var taskListID: UUID?
    var createdAt: Date?
    var jobId: UUID?
    var propertyId: UUID?
    var title: String?
    var task: [TaskModel]?
    var notes: String?
    
    enum CodingKeys: String, CodingKey {
        case title, task, notes
        case taskListID = "tasklist_id"
        case createdAt = "created_at"
        case jobId = "job_id"
        case propertyId = "property_id"
    }
}

struct TaskModel: Codable, Identifiable {
    var taskID: UUID?
    var title: String?
    var subtasks: [String]?
    var isComplete: Bool?
    var description: String?
    enum CodingKeys: String, CodingKey {
        case taskID = "task_id"
        case title, subtasks, isComplete, description
    }
    var id: UUID? {
        taskID
    }
}
