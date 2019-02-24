//
//  DetailViewModel.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import RxSwift
import RxCocoa

class DetailViewModel: KKBViewModel {
    let appInfo : BehaviorRelay<SoftwareModel?>  = BehaviorRelay<SoftwareModel?>(value: nil)
    
    required init() {
        super.init()
    }
}
