//
//  SearchResultAppInfoCell.swift
//  AppStore
//
//  Created by Kim JungMoo on 27/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class SearchResultAppInfoCell: UITableViewCell, KKBCellProtocol {
    @IBOutlet var iconImageView         : UIImageView?
    @IBOutlet var titleLabel            : UILabel?
    @IBOutlet var sellerNameLabel        : UILabel?
    
    @IBOutlet var previewImageViews     : [UIImageView]     = []
    @IBOutlet var ratingView            : CosmosView?
    
    var appInfo                         : SoftwareModel?
    
    func configure(_ data: SoftwareModel) {
        self.appInfo = data
        self.titleLabel?.text       = data.trackName
        self.sellerNameLabel?.text  = data.sellerName
        
        self.configureRating(data)
        self.configureIcon(data)
        self.configureScreenshot(data)
    }
    
    func configureRating(_ data: SoftwareModel) {
        self.ratingView?.isHidden = true
        
        guard let averageUserRating = data.averageUserRating else { return }
        guard let userRatingCount   = data.userRatingCount else { return }
        
        self.ratingView?.rating     = Double(averageUserRating)
        self.ratingView?.text       = userRatingCount.displayString
        self.ratingView?.isHidden   = false
    }
    
    func configureIcon(_ data: SoftwareModel) {
        guard let imageView = self.iconImageView else { return }
        let url = URL(string: data.artworkUrl100)
        KKBImageLoader.default.setImageView(imageView, url: url) { (_, _, cacheType) in
            guard cacheType != .memory else { return }
            imageView.startAlphaAnimating()
        }
    }
    
    func configureScreenshot(_ data: SoftwareModel) {
        if data.screenshotUrls.first?.sizeForScreenShot.isLandscape == true {
            KKBLog("landscape:: \(data.trackName)")
        }

        for i in 0..<self.previewImageViews.count {
            let imageView = self.previewImageViews[i]
            if i < data.screenshotUrls.count {
                imageView.isHidden = false
                let url = URL(string: data.screenshotUrls[i])
                KKBImageLoader.default.setImageView(imageView, url: url) { (_, _, cacheType) in
                    guard cacheType != .memory else { return }
                    imageView.startAlphaAnimating()
                }
            } else {
                imageView.isHidden = true
            }
        }
    }
    
    @IBAction func actionTouchUpInsideOpen(_ sender: Any?) {
        guard let appInfo = self.appInfo else { return }
        URL(string: appInfo.trackViewUrl)?.openWithSafari()
    }
}
