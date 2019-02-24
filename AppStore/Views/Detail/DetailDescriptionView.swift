//
//  DetailDescriptionView.swift
//  AppStore
//
//  Created by Kim JungMoo on 30/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

class DetailDescriptionView: UIView {
    @IBOutlet var descriptionLabel          : UILabel?
    @IBOutlet var moreWrapView              : UIView?
    
    func configure(_ data: SoftwareModel) {
        guard let descriptionLabel = descriptionLabel else { return }
        descriptionLabel.text = data.description
        self.moreWrapView?.isHidden = descriptionLabel.countLines <= 3
    }
    
    @IBAction func actionTouchUpInsideMore(_ sender: Any?) {
        self.moreWrapView?.isHidden = true
        self.descriptionLabel?.numberOfLines = 0
    }
}
