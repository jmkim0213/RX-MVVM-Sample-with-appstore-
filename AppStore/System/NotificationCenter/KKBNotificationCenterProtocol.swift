//
//  KKBNotificationCenterProtocol.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import RxSwift

protocol KKBNotificationCenterProtocol {
    var name: Notification.Name { get }
}

extension KKBNotificationCenterProtocol {
    func addObserver() -> Observable<Any?> {
        return NotificationCenter.default.rx.notification(self.name).map { $0.object }
    }
    
    func post(object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: self.name, object: object, userInfo: userInfo)
    }
}
