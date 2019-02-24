//
//  DetailExtraInfoItemView.swift
//  AppStore
//
//  Created by Kim JungMoo on 30/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

class DetailExtraInfoItemView: UIView {
    @IBOutlet var titleLabel        : UILabel?
    @IBOutlet var simpleInfoLabel   : UILabel?
    @IBOutlet var detailInfoLabel   : UILabel?
    @IBOutlet var arrowImageView    : UIImageView?

    func configure(title: String, simpleInfo: String, detailInfo: String? = nil) {
        self.titleLabel?.text = title
        self.simpleInfoLabel?.text = simpleInfo
        self.detailInfoLabel?.text = detailInfo
        self.detailInfoLabel?.isHidden = true
        
        self.arrowImageView?.isHidden = (detailInfo == nil)
    }
    
    @IBAction func actionTouchUpsideSelected(_ sender: Any?) {
        guard let text = self.detailInfoLabel?.text else { return }
        guard !text.isEmpty else { return }
        self.detailInfoLabel?.isHidden = false
        self.arrowImageView?.isHidden = true
        self.simpleInfoLabel?.text = nil
    }
}
