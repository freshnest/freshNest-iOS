//
//  TestData.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import Foundation

let scheduledJobs: [JobModel] = [
    JobModel(jobType: .available, amount: "$100", workItems: "2Bed 1Bath", timeToDestination: "15min away", address: "Fenway, Boston, Massachusetts", date: Date()),
    JobModel(jobType: .scheduled, amount: "$200", workItems: "3Bed 2Bath", timeToDestination: "20min away", address: "Beacon Hill, Boston, Massachusetts", date: Date().addingTimeInterval(86400)), // Adding 1 day
    JobModel(jobType: .scheduled, amount: "$150", workItems: "1Bed 1Bath", timeToDestination: "10min away", address: "Back Bay, Boston, Massachusetts", date: Date().addingTimeInterval(172800)), // Adding 2 days
    JobModel(jobType: .scheduled, amount: "$180", workItems: "2Bed 2Bath", timeToDestination: "25min away", address: "South End, Boston, Massachusetts", date: Date().addingTimeInterval(259200)), // Adding 3 days
    JobModel(jobType: .scheduled, amount: "$120", workItems: "Studio", timeToDestination: "12min away", address: "North End, Boston, Massachusetts", date: Date().addingTimeInterval(345600)), // Adding 4 days
    JobModel(jobType: .scheduled, amount: "$250", workItems: "4Bed 2Bath", timeToDestination: "30min away", address: "Charlestown, Boston, Massachusetts", date: Date().addingTimeInterval(432000)), // Adding 5 days
    JobModel(jobType: .scheduled, amount: "$90", workItems: "1Bed 1Bath", timeToDestination: "8min away", address: "Downtown Crossing, Boston, Massachusetts", date: Date().addingTimeInterval(518400)), // Adding 6 days
    JobModel(jobType: .scheduled, amount: "$300", workItems: "3Bed 3Bath", timeToDestination: "35min away", address: "Jamaica Plain, Boston, Massachusetts", date: Date().addingTimeInterval(604800)), // Adding 7 days
    JobModel(jobType: .scheduled, amount: "$175", workItems: "2Bed 1Bath", timeToDestination: "18min away", address: "Cambridge, Massachusetts", date: Date().addingTimeInterval(691200)), // Adding 8 days
    JobModel(jobType: .scheduled, amount: "$220", workItems: "3Bed 2Bath", timeToDestination: "22min away", address: "Brookline, Massachusetts", date: Date().addingTimeInterval(777600)), // Adding 9 days
    JobModel(jobType: .scheduled, amount: "$110", workItems: "1Bed 1Bath", timeToDestination: "14min away", address: "Somerville, Massachusetts", date: Date().addingTimeInterval(864000)), // Adding 10 days
    JobModel(jobType: .scheduled, amount: "$280", workItems: "2Bed 2Bath", timeToDestination: "27min away", address: "Newton, Massachusetts", date: Date().addingTimeInterval(950400)), // Adding 11 days
    JobModel(jobType: .scheduled, amount: "$130", workItems: "Studio", timeToDestination: "11min away", address: "Quincy, Massachusetts", date: Date().addingTimeInterval(1036800)), // Adding 12 days
    JobModel(jobType: .scheduled, amount: "$190", workItems: "2Bed 1Bath", timeToDestination: "16min away", address: "Medford, Massachusetts", date: Date().addingTimeInterval(1123200)) // Adding 13 days
]

let availableJobs: [JobModel] = [
    JobModel(jobType: .available, amount: "$80", workItems: "2Bed 1Bath", timeToDestination: "10min away", address: "Brighton, Boston, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$150", workItems: "3Bed 2Bath", timeToDestination: "18min away", address: "Dorchester, Boston, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$100", workItems: "1Bed 1Bath", timeToDestination: "15min away", address: "Roxbury, Boston, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$120", workItems: "Studio", timeToDestination: "12min away", address: "Allston, Boston, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$200", workItems: "4Bed 2Bath", timeToDestination: "20min away", address: "East Boston, Boston, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$90", workItems: "1Bed 1Bath", timeToDestination: "8min away", address: "Mattapan, Boston, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$250", workItems: "3Bed 3Bath", timeToDestination: "25min away", address: "Chelsea, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$175", workItems: "2Bed 1Bath", timeToDestination: "18min away", address: "Malden, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$220", workItems: "3Bed 2Bath", timeToDestination: "22min away", address: "Salem, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$110", workItems: "1Bed 1Bath", timeToDestination: "14min away", address: "Braintree, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$280", workItems: "2Bed 2Bath", timeToDestination: "27min away", address: "Watertown, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$130", workItems: "Studio", timeToDestination: "11min away", address: "Waltham, Massachusetts", date: Date()),
    JobModel(jobType: .available, amount: "$190", workItems: "2Bed 1Bath", timeToDestination: "16min away", address: "Revere, Massachusetts", date: Date())
]
