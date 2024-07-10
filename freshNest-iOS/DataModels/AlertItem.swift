//
//  AlertItem.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import Foundation

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    var buttonTitle: String = "OK"
    var action: (() -> Void)?
}
