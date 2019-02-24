//
//  SearchHomeViewModel.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchHomeViewModel: KKBViewModel {
    let cellTypes   : BehaviorRelay<[SearchHomeCellType]>    = BehaviorRelay<[SearchHomeCellType]>(value: [])
    
    required init() {
        super.init()
        self.initCellTypes()
    }
    
    func initCellTypes() {
        SearchKeywordLoader.observer(limit: 10)
        .map { [SearchHomeCellType.title] + $0.map { SearchHomeCellType.keyword(data: $0) } }
        .observeOn(MainScheduler.instance)
        .bind(to: self.cellTypes)
        .disposed(by: self.disposeBag)
    }
}
