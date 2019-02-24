//
//  KKBCellTypeProtocol.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

protocol KKBCellTypeProtocol {
    var identifier  : String { get }
    var height      : CGFloat { get }
    var dataKey     : String { get }
    var data        : Any? { get }
    
}

extension KKBCellTypeProtocol {
    var height      : CGFloat { return 0 }
    var dataKey     : String { return "" }
    var data        : Any? { return nil }
}
