//
//  UIColor+Utils.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

extension UIColor {
    var image: UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(self.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage
    }
    
    static func fromRed(_ red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat(red)        / 255.0
        let g = CGFloat(green)      / 255.0
        let b = CGFloat(blue)       / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}
