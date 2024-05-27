//
//  TestData.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import Foundation

let scheduledJobs: [JobModel] = [
    JobModel(jobType: .scheduled, amount: "$100", workItems: "2Bed 1Bath", timeToDestination: "15min away", address: "Fenway, Boston, Massachusetts", date: Date()),
    JobModel(jobType: .scheduled, amount: "$200", workItems: "3Bed 2Bath", timeToDestination: "20min away", address: "Beacon Hill, Boston, Massachusetts", date: Date().addingTimeInterval(86400)), // Adding 1 day
    JobModel(jobType: .scheduled, amount: "$150", workItems: "1Bed 1Bath", timeToDestination: "10min away", address: "Back Bay, Boston, Massachusetts", date: Date().addingTimeInterval(172800)), // Adding 2 days
    JobModel(jobType: .scheduled, amount: "$180", workItems: "2Bed 2Bath", timeToDestination: "25min away", address: "South End, Boston, Massachusetts", date: Date().addingTimeInterval(259200)), // Adding 3 days
    JobModel(jobType: .scheduled, amount: "$120", workItems: "Studio", timeToDestination: "12min away", address: "North End, Boston, Massachusetts", date: Date().addingTimeInterval(345600)), // Adding 4 days
    JobModel(jobType: .scheduled, amount: "$250", workItems: "4Bed 2Bath", timeToDestination: "30min away", address: "Charlestown, Boston, Massachusetts", date: Date().addingTimeInterval(432000)), // Adding 5 days
    JobModel(jobType: .scheduled, amount: "$90", workItems: "1Bed 1Bath", timeToDestination: "8min away", address: "Downtown Crossing, Boston, Massachusetts", date: Date().addingTimeInterval(518400)), // Adding 6 days
    JobModel(jobType: .scheduled, amount: "$300", workItems: "3Bed 3Bath", timeToDestination: "35min away", address: "Jamaica Plain, Boston, Massachusetts", date: Date().addingTimeInterval(604800)), // Adding 7 days
    JobModel(jobType: .scheduled, amount: "$175", workItems: "2Bed 1Bath", timeToDestination: "18min away", address: "Cambridge, Massachusetts", date: Date()), // Adding 8 days
    JobModel(jobType: .scheduled, amount: "$220", workItems: "3Bed 2Bath", timeToDestination: "22min away", address: "Brookline, Massachusetts", date: Date()), // Adding 9 days
    JobModel(jobType: .scheduled, amount: "$110", workItems: "1Bed 1Bath", timeToDestination: "14min away", address: "Somerville, Massachusetts", date: Date()), // Adding 10 days
    JobModel(jobType: .scheduled, amount: "$280", workItems: "2Bed 2Bath", timeToDestination: "27min away", address: "Newton, Massachusetts", date: Date()), // Adding 11 days
    JobModel(jobType: .scheduled, amount: "$130", workItems: "Studio", timeToDestination: "11min away", address: "Quincy, Massachusetts", date: Date().addingTimeInterval(86400)), // Adding 12 days
    JobModel(jobType: .scheduled, amount: "$190", workItems: "2Bed 1Bath", timeToDestination: "16min away", address: "Medford, Massachusetts", date: Date().addingTimeInterval(86400)) // Adding 13 days
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

var notifications: [NotificationCellData] = [
    NotificationCellData(image: "test_image1", name: "James", message: "Hi Ivy, I'll be arriving at your location in 45 minutes for the cleaning!", bookingStatus: "Upcoming Booking"),
    NotificationCellData(image: "profile", name: "Emily", message: "Great news! Your cleaning has been completed!", bookingStatus: "Completed"),
    NotificationCellData(image: "test_image1", name: "John", message: "Just letting you know that the cleaning for your Airbnb is currently in progress.", bookingStatus: "Scheduled"),
    NotificationCellData(image: "profile", name: "Sophia", message: "Hello, I've just started cleaning your place. Everything looks good so far!", bookingStatus: "In Progress"),
    NotificationCellData(image: "test_image1", name: "David", message: "Hi there! I'm about to start cleaning your Airbnb. Let me know if you need anything specific.", bookingStatus: "Upcoming Booking"),
    NotificationCellData(image: "profile", name: "Olivia", message: "Your Airbnb cleaning is complete. Please let me know if you need any additional services!", bookingStatus: "Completed"),
    NotificationCellData(image: "test_image1", name: "Ethan", message: "Just finished cleaning. Your Airbnb is now ready for the next guests!", bookingStatus: "Completed")
]


struct Earning: Identifiable, Hashable {
    let id = UUID()
    var address: String
    var date: String
    var amount: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

let earnings: [Earning] = [
       Earning(address: "123 Elm Street, Springfield", date: "1st May 2024", amount: "$100.00"),
       Earning(address: "456 Oak Avenue, Springfield", date: "2nd May 2024", amount: "$150.00"),
       Earning(address: "789 Pine Lane, Springfield", date: "3rd May 2024", amount: "$200.00"),
       Earning(address: "101 Maple Road, Springfield", date: "4th May 2024", amount: "$250.00"),
       Earning(address: "202 Birch Street, Springfield", date: "5th May 2024", amount: "$300.00"),
       Earning(address: "303 Cedar Avenue, Springfield", date: "6th May 2024", amount: "$350.00"),
       Earning(address: "404 Walnut Drive, Springfield", date: "7th May 2024", amount: "$400.00"),
       Earning(address: "505 Chestnut Blvd, Springfield", date: "8th May 2024", amount: "$450.00"),
       Earning(address: "606 Beech Terrace, Springfield", date: "9th May 2024", amount: "$500.00"),
       Earning(address: "707 Poplar Street, Springfield", date: "10th May 2024", amount: "$550.00")
   ]
