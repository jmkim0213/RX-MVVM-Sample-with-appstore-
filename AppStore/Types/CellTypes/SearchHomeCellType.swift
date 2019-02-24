//
//  SearchHomeCellType.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

enum SearchHomeCellType: KKBCellTypeProtocol {
    case title
    case keyword(data: SearchKeywordModel2)
    
    var identifier: String {
        switch self {
        case .title:
            return "SearchTitleCell"
        case .keyword:
            return "SearchRecentKeywordCell"
        }
    }

    var height: CGFloat {
        switch self {
        case .title:
            return 60
        case .keyword:
            return 50
        }
    }
    
    var data: Any? {
        switch self {
        case .title:
            return nil
        case .keyword(let data):
            return data
        }
    }
    
    var dataKey: String {
        switch self {
        case .title:
            return "title"
        case .keyword(let data):
            return "keyword: \(data.term)"
        }
    }
}
