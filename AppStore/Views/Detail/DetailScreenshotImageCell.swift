//
//  DetailScreenshotImageCell.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit

class DetailScreenshotImageCell: UICollectionViewCell, KKBCellProtocol {
    @IBOutlet var imageView     : UIImageView?
    
    func configure(_ data: String) {
        guard let imageView = self.imageView else { return }
        let url = URL(string: data)
        KKBImageLoader.default.setImageView(imageView, url: url) { _, _, cacheType in
            guard cacheType != .memory else { return }
            imageView.startAlphaAnimating()
        }
    }
}
