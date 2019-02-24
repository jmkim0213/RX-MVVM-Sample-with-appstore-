//
//  SoftwareSearchLoader.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct SearchAppInfoLoader {
    static func load(keyword: String) -> Observable<SoftwareListInfo> {
        return AppStoreApi.search(keyword: keyword).request(SoftwareListInfo.self)
    }
}
