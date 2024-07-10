//
//  String+.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import Foundation

extension String {
    func formatCardNumber() -> String {
        var formattedString = ""
        var index = 0
        for character in self {
            if index > 0 && index % 4 == 0 {
                formattedString += " "
            }
            formattedString.append(character)
            index += 1
        }
        return formattedString
    }
    
    func maskCardNumber() -> String {
           var maskedString = ""
           var index = 0
           for character in self {
               if index < count - 4 {
                   if character.isNumber {
                       maskedString.append("•")
                   } else {
                       maskedString.append(character)
                   }
               } else {
                   maskedString.append(character)
               }
               index += 1
           }
           return maskedString.formatCardNumber()
       }
}

extension String {
    func formattedPhoneNumber() -> String {
        // Ensure the phone number string contains only digits
        let digits = self.filter { $0.isNumber }
        
        // Check if the phone number has the required length
        guard digits.count == 10 else {
            return self
        }
        
        // Format the phone number as +1 (XXX) XXXXX
        let areaCode = digits.prefix(3)
        let remaining = digits.suffix(7)
        let formatted = "+1 (\(areaCode)) \(remaining.prefix(5))\(remaining.suffix(2))"
        
        return formatted
    }
}
