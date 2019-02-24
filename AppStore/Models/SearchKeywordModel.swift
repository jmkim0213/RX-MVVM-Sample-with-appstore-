//
//  SearchKeywordModel.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation

class SearchKeywordModel2: NSObject, NSCoding {
    var term            : String = ""
    var chosung         : String = ""
    
    init(term: String, chosung: String) {
        self.term = term
        self.chosung = chosung
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.term       = aDecoder.decodeObject(forKey: "term")     as? String ?? ""
        self.chosung    = aDecoder.decodeObject(forKey: "chosung")  as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.term,    forKey: "term")
        aCoder.encode(self.chosung, forKey: "chosung")
    }
    
    static func == (lhs: SearchKeywordModel2, rhs: SearchKeywordModel2) -> Bool {
        return lhs.term == rhs.term
    }
}
