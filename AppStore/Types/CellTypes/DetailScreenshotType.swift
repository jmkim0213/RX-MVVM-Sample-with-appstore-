//
//  DetailScreenshotImageType.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit

enum DetailScreenshotType: KKBCellTypeProtocol, Equatable {
    case portrait(url: String)

    var identifier: String {
        switch self {
        case .portrait:
            return "DetailScreenshotImageCell"
        }
    }
    
    var height: CGFloat {
        switch self {
        case .portrait:
            return 250
        }
    }
    
    var data: Any? {
        switch self {
        case .portrait(let data):
            return data
        }
    }
    
    var dataKey: String {
        switch self {
        case .portrait(let data):
            return "portrait_\(data)"
        }
    }
    
    static func == (lhs: DetailScreenshotType, rhs: DetailScreenshotType) -> Bool {
        return lhs.dataKey == rhs.dataKey
    }
}
