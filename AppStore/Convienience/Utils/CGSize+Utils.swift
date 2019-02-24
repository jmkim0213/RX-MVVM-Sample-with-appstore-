//
//  CGSize+Utils.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {
    var isLandscape: Bool { return self.width > self.height }
    
    func sizeFitFromViewHeight(_ view: UIView) -> CGSize {
        let newHeight = view.bounds.size.height
        let newWidth = self.width * (newHeight / self.height)
        
        return CGSize(width: newWidth, height: newHeight)
    }
}
