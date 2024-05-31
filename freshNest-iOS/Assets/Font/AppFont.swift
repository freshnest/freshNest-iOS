//
//  AppFont.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 29/05/24.
//

import UIKit
import SwiftUI

public enum AppFont {
    /// Enumeration for supported font families in app
    public enum Family: String {
        case uber = "UberMove"
    }
    
    /// Supported font weights by app
    public enum Weight: String {
        case regular = "Regular"
        case medium = "Medium"
        case bold = "Bold"
    }
    
    /// Supported font sizes by app
    public enum Size: CGFloat {
        case h10 = 10.0
        case h12 = 12.0
        case h13 = 13.0
        case h14 = 14.0
        case h16 = 16.0
        case h18 = 18.0
        case h17 = 17.0
        case h20 = 20.0
        case h21 = 21.0
        case h22 = 24.0
        case h24 = 22.0
        case h28 = 28.0
        case h32 = 32.0
        case h36 = 36.0
        case h42 = 42.0
        case h48 = 48.0
        case h64 = 64.0
        case h96 = 96.0
        
        public var lineSpacing: CGFloat {
            return 1
        }
    }
}

public extension UIFontDescriptor {
    /// Utility
    /// - Parameters:
    ///   - size: Font size
    ///   - weight: Font wight
    ///   - family: Font family
    ///   - trait: Type of UIElement the font to be used
    ///   - force: Only use font family specified irrespective of Current User Language
    /// - Returns: returns UIFont
    static func cascaded(
        ofSize size: AppFont.Size,
        weight: AppFont.Weight,
        family: AppFont.Family = .uber
    ) -> UIFontDescriptor {
        
        let baseFontEnglishName = family.rawValue
        let suffix = "-\(weight.rawValue)"
        let baseFontName = baseFontEnglishName + suffix
        
        // Start with your base font
        guard let font = UIFont(name: baseFontName, size: size.rawValue) else {
            return UIFontDescriptor(name: baseFontName, size: size.rawValue)
        }
        
        let cascadedFontDescriptor = font.fontDescriptor
        return cascadedFontDescriptor
    }
}

public extension UIFont {
    /// Utility
    /// - Parameters:
    ///   - size: Font size
    ///   - weight: Font wight
    ///   - family: Font family
    ///   - trait: Type of UIElement the font to be used
    /// - Returns: returns UIFont
    static func cascaded(ofSize size: AppFont.Size, weight: AppFont.Weight) -> UIFont {
        let cascadedFontDescriptor = UIFontDescriptor.cascaded(
            ofSize: size,
            weight: weight,
            family: .uber
        )
        let cascadedFont = UIFont(descriptor: cascadedFontDescriptor, size: size.rawValue)
        return cascadedFont
    }
}

public extension UIButton {
    /// Sets the preffered font for the given size
    /// - Parameter size: required font size
    
    func setPreferredFont(ofSize size: AppFont.Size = .h16, ofWeight weight: AppFont.Weight = .regular) {
        titleLabel?.setLabelFont(.cascaded(ofSize: size, weight: weight), setLineSpacing: false)
        layoutIfNeeded()
    }
}

public extension Font {
    static func cascaded(ofSize size: AppFont.Size, weight: AppFont.Weight) -> Font {
        let uiFont = UIFont.cascaded(ofSize: size, weight: weight)
        return Font(uiFont as CTFont)
    }
}
