//
//  ApplicationNotificationCenter.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit

enum ApplicationNotificationCenter: KKBNotificationCenterProtocol {
    case didReceiveMemoryWarning
    
    var name: Notification.Name {
        switch self {
        case .didReceiveMemoryWarning:
            return UIApplication.didReceiveMemoryWarningNotification
        }
    }
}
