//
//  SearchAPI.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import RxSwift

enum AppStoreApi {
    case search(keyword: String)
}

extension AppStoreApi: KKBRestApiProtocol {
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    var method: KKBHttpMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var parameters: [String:String] {
        switch self {
        case .search(let keyword):
            return ["term":keyword, "lang":"ko-kr", "country":"KR", "entity":"software"]
        }
    }
}
