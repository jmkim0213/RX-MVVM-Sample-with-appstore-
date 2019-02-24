//
//  DetailDeveloperView.swift
//  AppStore
//
//  Created by Kim JungMoo on 30/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

class DetailDeveloperView: UIView {
    @IBOutlet var developerLabel        : UILabel?
    
    func configure(_ data: SoftwareModel) {
        self.developerLabel?.text = data.sellerName
    }
}
