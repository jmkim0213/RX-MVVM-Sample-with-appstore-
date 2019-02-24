//
//  KKBNavigationController.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

class KKBNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
