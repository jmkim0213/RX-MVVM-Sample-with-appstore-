//
//  UIView+Utils.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

extension UIView {
    func startAlphaAnimating(_ duration: TimeInterval = 0.3) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
}

extension UIView {
    func copyView() -> UIView? {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? UIView
    }
}
