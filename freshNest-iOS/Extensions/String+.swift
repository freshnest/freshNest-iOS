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
