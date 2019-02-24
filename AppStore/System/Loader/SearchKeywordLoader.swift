//
//  SearchKeywordLoader.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

private let kKeyKeywords    : String = "kKeyKeywords"
private let kLimitKeywords  : Int    = 50

struct SearchKeywordLoader {
    private static let keywords: BehaviorRelay<[SearchKeywordModel2]> = {
        guard let data = UserDefaults.standard.value(forKey: kKeyKeywords) as? Data else { return BehaviorRelay(value: []) }
        guard let keywords = NSKeyedUnarchiver.unarchiveObject(with: data) as? [SearchKeywordModel2] else { return BehaviorRelay(value: []) }
        return BehaviorRelay<[SearchKeywordModel2]>(value: keywords)
    }()
    
    static func observer(limit: Int) -> Observable<[SearchKeywordModel2]> {
        return self.keywords.map { $0.isEmpty ? $0 : Array($0[0...min(limit, $0.count - 1)]) }.distinctUntilChanged()
    }
    
    static func load(keyword: String) -> Observable<[SearchKeywordModel2]> {
        return self.keywords.map {
            return $0.filter {
                keyword.isChosungOnly ? $0.chosung.contains(keyword) : $0.term.contains(keyword)
            }
        }.take(1).distinctUntilChanged()
    }
    
    static func add(_ keyword: String) {
        var keywords = self.keywords.value
        let newKeyword = SearchKeywordModel2(term: keyword, chosung: keyword.chosung)
        
        keywords.removeAll { $0 == newKeyword }
        keywords.insert(newKeyword, at: 0)
        
        if keywords.count >= kLimitKeywords {
            keywords = Array(keywords[0...kLimitKeywords - 1])
        }
        self.keywords.accept(keywords)
    }
    
    static func synchronize() {
        let data = NSKeyedArchiver.archivedData(withRootObject: self.keywords.value)
        UserDefaults.standard.set(data, forKey: kKeyKeywords)
        UserDefaults.standard.synchronize()
    }
}
