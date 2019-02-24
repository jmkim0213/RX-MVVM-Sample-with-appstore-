//
//  SearchCellType.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

enum SearchCellType: KKBCellTypeProtocol, Equatable {
    case keyword(model: SearchKeywordModel2, keyword: String)
    case appInfo(data: SoftwareModel)
    
    var identifier: String {
        switch self {
        case .keyword:
            return "SearchResultRecentKeywordCell"
        case .appInfo:
            return "SearchResultAppInfoCell"
        }
    }
    
    var height: CGFloat {
        switch self {
        case .keyword:
            return 50
        case .appInfo:
            return 310
        }
    }
    
    var data: Any? {
        switch self {
        case .keyword(let data):
            return data
        case .appInfo(let data):
            return data
        }
    }
    
    var dataKey: String {
        switch self {
        case .keyword(let data):
            return "keyword_\(data)"
        case .appInfo(let data):
            return "appInfo_\(data)"
        }
    }
    
    static func == (lhs: SearchCellType, rhs: SearchCellType) -> Bool {
        return lhs.dataKey == rhs.dataKey
    }
}
