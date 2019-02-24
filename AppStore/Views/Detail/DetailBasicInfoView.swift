//
//  DetailBasicInfoView.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class DetailBasicInfoView: UIView {
    @IBOutlet var iconImageView             : UIImageView?
    @IBOutlet var titleLabel                : UILabel?
    @IBOutlet var sellerNameLabel           : UILabel?
    
    @IBOutlet var ratingLabel               : UILabel?
    @IBOutlet var ratingView                : CosmosView?
    @IBOutlet var ratingCountLabel          : UILabel?
    @IBOutlet var categoryLabel             : UILabel?
    @IBOutlet var contentRatingLabel        : UILabel?
    
    var appInfo                             : SoftwareModel?

    func configure(_ data: SoftwareModel) {
        self.appInfo                    = data
        self.titleLabel?.text           = data.trackName
        self.sellerNameLabel?.text      = data.sellerName
        
        self.categoryLabel?.text        = data.genres.first
        self.contentRatingLabel?.text   = data.trackContentRating
        
        self.configureRating(data)
        self.configureIcon(data)
    }
    
    func configureRating(_ data: SoftwareModel) {
        self.ratingView?.rating = 0
        self.ratingLabel?.text = ""
        self.ratingCountLabel?.text = "평가부족"
        guard let averageUserRating = data.averageUserRating else { return }
        guard let userRatingCount   = data.userRatingCount else { return }
        
        self.ratingView?.rating         = Double(averageUserRating)
        self.ratingLabel?.text          = "\(averageUserRating)"
        self.ratingCountLabel?.text     = "\(userRatingCount.displayString)개의 평가"
    }
    
    func configureIcon(_ data: SoftwareModel) {
        guard let iconImageView = self.iconImageView else { return }
        let url = URL(string: data.artworkUrl100)
        KKBImageLoader.default.setImageView(iconImageView, url: url) { (_, _, cacheType) in
            guard cacheType != .memory else { return }
            iconImageView.startAlphaAnimating()
        }
    }
    
    @IBAction func actionTouchUpInsideOpen(_ sender: Any?) {
        guard let appInfo = self.appInfo else { return }
        URL(string: appInfo.trackViewUrl)?.openWithSafari()
    }
}
