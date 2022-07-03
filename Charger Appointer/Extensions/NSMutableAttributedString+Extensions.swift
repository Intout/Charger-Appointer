//
//  NSMutableAttributedString+Extensions.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 2.07.2022.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func highlight(color: UIColor, forText stringValue: String, in fontSize: Int) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: ApplicationFonts.bold.rawValue, size: CGFloat(fontSize))!, range: range)
    }
    
}
