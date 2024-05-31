//
//  Label+.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 29/05/24.
//

import UIKit

extension UILabel {
    
    func setLabelFont(_ font: UIFont, setLineSpacing: Bool = true, shouldStrikeThrough: Bool = false) {
        self.font = font
        if setLineSpacing {
            self.setLineSpacing(shouldStrikeThrough: shouldStrikeThrough)
        }
    }
    
    var lineCount: Int {
        self.layoutIfNeeded()
        guard let myText = self.text as NSString? else {
            return 0
        }
        let rect = CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(
            with: rect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: self.font as Any],
            context: nil
        )
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
    
    func setLineSpacing(
        lineHeightMultiple: CGFloat? = 0.0,
        lineSpacing: CGFloat = 0.0,
        shouldStrikeThrough: Bool = false,
        additionalAttributes: [NSAttributedString.Key: Any] = [:]
    ) {
        guard let labelText = self.text else { return }
        lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineBreakMode = .byTruncatingTail
        if let lineSpacing = AppFont.Size(rawValue: self.font.pointSize)?.lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }
        
        var attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        attributes.merge(additionalAttributes, uniquingKeysWith: { _, new in new })
        
        if shouldStrikeThrough {
            attributes.updateValue(NSUnderlineStyle.single.rawValue, forKey: .strikethroughStyle)
        }
        self.attributedText = NSMutableAttributedString(
            string: labelText,
            attributes: attributes
        )
    }
}
