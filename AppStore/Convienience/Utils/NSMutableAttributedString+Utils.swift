//
//  NSMutableAttributedString.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func setFont(_ color: UIColor, text: String?) {
        guard let text = text else { return }
        let range = self.mutableString.range(of: text, options: .caseInsensitive) 
        guard range.location != NSNotFound else { return }
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    func setFont(_ font: UIFont, text: String?) {
        guard let text = text else { return }
        let range = self.mutableString.range(of: text, options: .caseInsensitive)
        guard range.location != NSNotFound else { return }
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
}
