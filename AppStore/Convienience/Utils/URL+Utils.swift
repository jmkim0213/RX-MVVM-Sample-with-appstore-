//
//  URL+Utils.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation

import UIKit

extension URL {
    func openWithSafari() {
        UIApplication.shared.open(self, options: [:], completionHandler: nil)
    }
    
    var queryDictionary: [String:String] {
        var resultDic = [String:String]()
        let queryArray = self.query?.split(separator: "&") ?? []
        for query in queryArray {
            let keyAndValue = query.split(separator: "=")
            let key     = keyAndValue[0].removingPercentEncoding ?? ""
            let value   = keyAndValue[1].removingPercentEncoding ?? ""
            resultDic[key] = value
        }
        return resultDic
    }
}
