//
//  TaskFlowData.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 14/05/24.
//

import Foundation
import SwiftUI

struct TaskItem: Identifiable {
    var title: String
    var description: String
    var subtasks: [String]
    var id: String {
        title
    }
}

let taskFlow: [TaskItem] = [
    TaskItem(
        title: "Floor Cleaning",
        description: "Sweep, mop, and vacuum all floors in the apartment.",
        subtasks: [
            "Vacuum all carpets and rugs.",
            "Sweep hard floors to remove loose dirt and debris.",
            "Pay special attention to corners and under furniture."
        ]
    ),
    TaskItem(
        title: "Washing Sheets",
        description: "Strip beds of used sheets, sort, wash, and dry them.",
        subtasks: [
            "Strip beds of used sheets, pillowcases, and duvet covers.",
            "Sort linens by color and fabric type."
        ]
    ),
    TaskItem(
        title: "Drying Sheets",
        description: "Ensure sheets are thoroughly dried before folding.",
        subtasks: [
            "Ensure sheets are completely dry before removing from the dryer."
        ]
    ),
    TaskItem(
        title: "Dusting Furniture and Surfaces",
        description: "Dust all furniture surfaces and shelves.",
        subtasks: [
            "Pay special attention to electronics and fragile items.",
            "Dust any decorative items or ornaments."
        ]
    ),
    TaskItem(
        title: "Cleaning Kitchen Appliances",
        description: "Wipe down kitchen appliances to remove any dirt or grease.",
        subtasks: [
            "Empty and clean the sink."
        ]
    ),
    TaskItem(
        title: "Sanitizing Bathroom",
        description: "Clean and disinfect all surfaces in the bathroom.",
        subtasks: [
            "Scrub and disinfect the sink, toilet, bathtub, and shower.",
            "Clean mirrors with glass cleaner to ensure they're streak-free.",
            "Wipe down all surfaces with disinfectant wipes.",
            "Replace towels with fresh ones."
        ]
    ),
    TaskItem(
        title: "Emptying Trash Bins",
        description: "Remove trash from all bins and replace with fresh liners.",
        subtasks: [
            "Gather all trash from around the apartment.",
            "Empty trash bins in the kitchen, bathroom, and bedrooms.",
            "Replace liners in each bin."
        ]
    ),
    TaskItem(
        title: "Vacuuming Carpets and Rugs",
        description: "Vacuum all carpets and rugs to remove dirt and debris.",
        subtasks: [
            "Vacuum all carpets and rugs in the apartment.",
            "Use attachments to vacuum corners, edges, and under furniture.",
            "Pay extra attention to high-traffic areas and pet hair."
        ]
    ),
    TaskItem(
        title: "Cleaning Windows and Glass Surfaces",
        description: "Clean windows and glass surfaces to ensure clarity.",
        subtasks: [
            "Clean windows and glass surfaces with glass cleaner.",
            "Wipe down window sills and frames.",
            "Use a lint-free cloth to ensure windows are streak-free.",
            "Clean any glass tables or decorative glass surfaces."
        ]
    ),
    TaskItem(
        title: "Tidying Up",
        description: "Ensure all items are neatly arranged and surfaces are clear.",
        subtasks: [
            "Straighten up any misplaced items throughout the apartment.",
            "Return books, magazines, and personal belongings to their proper places.",
            "Arrange pillows and cushions neatly.",
            "Ensure all surfaces are clear and clutter-free."
        ]
    )
]

