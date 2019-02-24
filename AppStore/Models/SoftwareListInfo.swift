//
//  SearchInfoModel.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation

struct SoftwareListInfo: Codable {
    var resultCount     : Int               = 0
    var results         : [SoftwareModel]   = []
}
