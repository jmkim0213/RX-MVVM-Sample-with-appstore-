//
//  KKBRequestStateProtocol.swift
//  AppStore
//
//  Created by Kim JungMoo on 28/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation

enum KKBRequestState<R> {
    case initial
    case loading
    case success(result: R)
    case fail(error: Error)
}

extension KKBRequestState {
    var id: String {
        switch self {
        case .initial:
            return "initial"
        case .loading:
            return "loading"
        case .success:
            return "success"
        case .fail:
            return "fail"
        }
    }
}

extension KKBRequestState: Equatable {
    static func == (lhs: KKBRequestState, rhs: KKBRequestState) -> Bool {
        return lhs.id == rhs.id
    }
}
