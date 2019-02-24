//
//  DetailExtraInfoView.swift
//  AppStore
//
//  Created by Kim JungMoo on 30/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

class DetailExtraInfoView: UIView {
    @IBOutlet var stackView         : UIStackView?
    @IBOutlet var sellerItemView    : DetailExtraInfoItemView?
    @IBOutlet var sizeItemView      : DetailExtraInfoItemView?
    @IBOutlet var categoryItemView  : DetailExtraInfoItemView?
    @IBOutlet var supportItemView   : DetailExtraInfoItemView?
    @IBOutlet var ageItemView       : DetailExtraInfoItemView?
    @IBOutlet var priceItemView     : DetailExtraInfoItemView?

    func configure(_ data: SoftwareModel) {
        self.configureSeller(data)
        self.configureSize(data)
        self.configureCategory(data)
        self.configureSupport(data)
        self.configureAge(data)
        self.configurePriceItem(data)
    }
    
    func configureSeller(_ data: SoftwareModel) {
        guard let sellerItemView = self.sellerItemView else { return }
        sellerItemView.configure(title: "판매자", simpleInfo: data.sellerName)
    }
    
    func configureSize(_ data: SoftwareModel) {
        guard let sizeItemView = self.sizeItemView else { return }
        if let fileSize = Int64(data.fileSizeBytes) {
            sizeItemView.configure(title: "크기", simpleInfo: fileSize.displayFileSizeString)
        } else {
            sizeItemView.isHidden = true
        }
    }
    
    func configureCategory(_ data: SoftwareModel) {
        guard let categoryItemView = self.categoryItemView else { return }
        categoryItemView.configure(title: "카테고리", simpleInfo: data.genres.first ?? "",
                                   detailInfo: data.genres.count > 1 ? data.genres.joined(separator: ", ") : nil)
    }
    
    func configureSupport(_ data: SoftwareModel) {
        guard let supportItemView = self.supportItemView else { return }
        supportItemView.configure(title: "호환성", simpleInfo: data.supportedDevices.first ?? "",
                                  detailInfo: data.supportedDevices.count > 1 ? data.supportedDevices.joined(separator: ", ") : nil)
    }
    
    func configureAge(_ data: SoftwareModel) {
        guard let ageItemView = self.ageItemView else { return }
        ageItemView.configure(title: "연령", simpleInfo: data.trackContentRating)
    }
    
    func configurePriceItem(_ data: SoftwareModel) {
        guard let priceItemView = self.priceItemView else { return }
        priceItemView.configure(title: "가격", simpleInfo: data.formattedPrice)
    }
}
