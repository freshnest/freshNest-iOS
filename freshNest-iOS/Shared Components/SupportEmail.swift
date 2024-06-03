//
//  SupportEmail.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import Foundation
import UIKit
import SwiftUI


struct SupportEmail {
    let toAddress: String
    let subject: String
    var body: String { """
        Application Name: \(Bundle.main.displayName) |
        iOS: \(UIDevice.current.systemVersion) |
        Device Model: \(UIDevice.current.modelName) |
        App Version: \(Bundle.main.appVersion) |
        App Build: \(Bundle.main.appBuild) |
    --------------------------------------
    """
    }

    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        guard let url = URL(string: urlString) else { return }
        openURL(url)
    }
}
