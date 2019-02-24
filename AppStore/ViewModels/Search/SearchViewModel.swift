//
//  SearchViewModel.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchViewModel: KKBViewModel {
    typealias AppInfoRequestState = KKBRequestState<Any?>
    let cellTypes                   : BehaviorRelay<[SearchCellType]>       = BehaviorRelay<[SearchCellType]>(value: [])
    let searchMode                  : BehaviorRelay<SearchMode>             = BehaviorRelay<SearchMode>(value: .keyword)
    let appInfoRequestState         : BehaviorRelay<AppInfoRequestState>    = BehaviorRelay<AppInfoRequestState>(value: .initial)
    
    var isHiddenEmptyViewObserver   : Observable<Bool> {
        return Observable.combineLatest(self.searchMode, self.cellTypes, self.appInfoRequestState).map { !($0.0 == .appInfo && $0.1.isEmpty && $0.2 != .loading) }.distinctUntilChanged()
    }
    
    required init() {
        
    }
    
    func loadRecent(keyword: String) {
        self.searchMode.accept(.keyword)
        SearchKeywordLoader.load(keyword: keyword)
        .map { $0.map { SearchCellType.keyword(model: $0, keyword: keyword) } }
        .distinctUntilChanged()
        .bind(to: self.cellTypes)
        .disposed(by: self.disposeBag)
    }
    
    func updateKeyword(keyword: String) {
        SearchKeywordLoader.add(keyword)
    }
    
    func loadAppInfo(keyword: String) {
        self.appInfoRequestState.accept(.loading)
        self.searchMode.accept(.appInfo)
        SearchAppInfoLoader.load(keyword: keyword)
        .map { $0.results.map { SearchCellType.appInfo(data: $0) } }
        .distinctUntilChanged()
        .subscribe(onNext: { [weak self] cellTypes in
            self?.updateKeyword(keyword: keyword)
            self?.cellTypes.accept(cellTypes)
            self?.appInfoRequestState.accept(.success(result: nil))
        }, onError: { [weak self] (error) in
            error.showAlert()
            self?.appInfoRequestState.accept(.fail(error: error))
        }).disposed(by: self.disposeBag)
    }
}
