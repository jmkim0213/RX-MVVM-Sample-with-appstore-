//
//  String+Utils.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit

private let kHangulFirstCode        = UInt32(0xAC00)
private let kHangulLastCode         = UInt32(0xD79F)
private let kChosungs               = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
extension String {
    var isHangulOnly: Bool {
        return self.range(of: "^[ㄱ-ㅎㅏ-ㅣ가-힣\\s]", options: .regularExpression) != nil
    }
    
    var isChosungOnly: Bool {
        return self.range(of: "^[ㄱ-ㅎ\\s]", options: .regularExpression) != nil
    }
    
    var chosung: String {
        let characters = Array(self)
        var resultBuilder = ""
        for character in characters {
            guard let unicode = character.unicodeScalars.first?.value else { continue }
            if kHangulFirstCode <= unicode && unicode <= kHangulLastCode {
                let chosungIndex = Int((unicode - kHangulFirstCode) / (28 * 21))
                resultBuilder += kChosungs[chosungIndex]
            }
        }
        return resultBuilder
    }
    
    var sizeForScreenShot: CGSize {
        if let fileName = self.split(separator: "/").last {
            let sizeStr = fileName.replacingOccurrences(of: "bb.jpg", with: "")
            guard let width = sizeStr.split(separator: "x").first else { return .zero }
            guard let height = sizeStr.split(separator: "x").last else { return .zero }
            return CGSize(width: Int(width) ?? 0, height: Int(height) ?? 0)
        }
        return .zero
    }
}
