//
//  DetailScreenshotView.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DetailScreenshotView: UIView {
    @IBOutlet var collectionView    : UICollectionView?
    let urls                        : BehaviorRelay<[String]>       = BehaviorRelay<[String]>(value: [])
    let disposeBag                  : DisposeBag                    = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let collectionView = self.collectionView else { return }
        
        self.urls.map { $0.map { DetailScreenshotType.portrait(url: $0) } }.distinctUntilChanged()
        .bind(to: collectionView.rx.items) { collectionView, row, cellType in
            return collectionView.configuredCell(cellType, for: IndexPath(row: row, section: 0))
        }.disposed(by: self.disposeBag)
    }
    
    func configure(_ data: SoftwareModel) {
        self.urls.accept(data.screenshotUrls)
        
        self.configureCollectionView(data.screenshotUrls.first)
        self.collectionView?.reloadData()
    }
    
    func configureCollectionView(_ data: String?) {
        guard let collectionView = self.collectionView else { return }
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        guard let data = data else { return }
        
        let itemSize = data.sizeForScreenShot.sizeFitFromViewHeight(collectionView)
        
        flowLayout.itemSize = itemSize
    }
    
    func startAnimating() {
        self.superview?.bringSubviewToFront(self)
        self.transform.ty = -(self.bounds.height / 2)
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.transform.ty = 0
        }
    }
}
