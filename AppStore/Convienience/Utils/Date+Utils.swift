//
//  Date+Utils.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation

extension Date {
    var displayStringFromToday: String {
        let diffTimeInterval = Date().timeIntervalSince1970 - self.timeIntervalSince1970
        
        let year = diffTimeInterval / (60 * 60 * 24 * 365)
        if Int(year) > 0 {
            return "\(Int(year))년 전"
        }
        
        let month = year * 12
        if Int(month) > 0 {
            return "\(Int(month))개월 전"
        }
        
        let week = month * 4.345
        if Int(week) > 0 {
            return "\(Int(week))주 전"
        }
        
        let day = week * 7
        if Int(day) > 0 {
            return "\(Int(day))일 전"
        }
        
        return "오늘"
    }
}
