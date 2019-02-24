//
//  UIView+Layer.swift
//  AppStore
//
//  Created by Kim JungMoo on 27/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius : CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor : UIColor {
        get {
            if let cgcolor = self.layer.borderColor {
                return UIColor(cgColor: cgcolor)
            } else {
                return UIColor.clear
            }
        }
        set { self.layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable var masksToBounds : Bool {
        get { return self.layer.masksToBounds }
        set { self.layer.masksToBounds = newValue }
    }
}
