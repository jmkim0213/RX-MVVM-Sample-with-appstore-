//
//  Int+Utils.swift
//  AppStore
//
//  Created by Kim JungMoo on 28/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation

extension Int {
    var displayString: String {
        switch self {
        case 1...999:
            return "\(self)"
        case 1000...9999:
            return String(format: "%.2f천", Float(self) / 1000).replacingOccurrences(of: ".0", with: "")
        case 10000...self:
            return String(format: "%.1f만", Float(self) / 10000).replacingOccurrences(of: ".0", with: "")
        default:
            return ""
        }
    }
}

extension Int64 {
    var displayFileSizeString: String {
        let formatter = ByteCountFormatter()
        return formatter.string(fromByteCount: self)
    }
}
