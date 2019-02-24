//
//  KKBImageCache.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class KKBImageCache {
    static let `default` = {
        return KKBImageCache(name: "default")
    }()
    
    private let memoryCache      : NSCache<NSString, AnyObject> = NSCache<NSString, AnyObject>()
    private let disposeBag       : DisposeBag                   = DisposeBag()
    
    var maxMemoryCost: Int {
        set { self.memoryCache.totalCostLimit = newValue }
        get { return self.memoryCache.totalCostLimit }
    }
    
    init(name: String) {
        self.memoryCache.name = name
        ApplicationNotificationCenter.didReceiveMemoryWarning.addObserver().bind { [weak self] _ in
            self?.memoryCache.removeAllObjects()
        }.disposed(by: self.disposeBag)
    }
    
    func addCache(url: URL?, image: UIImage) {
        guard let url = url else { return }
        let key = NSString(string: url.absoluteString)
        self.memoryCache.setObject(image, forKey: key, cost: self.imageCost(image))
    }
    
    func removeCache(url: URL?) {
        guard let url = url else { return }
        let key = NSString(string: url.absoluteString)
        self.memoryCache.removeObject(forKey: key)
    }
    
    func retrieveImage(url: URL?) -> UIImage? {
        guard let url = url else { return nil }
        let key = NSString(string: url.absoluteString)
        return self.memoryCache.object(forKey: key) as? UIImage
    }
    
    private func imageCost(_ image: UIImage) -> Int {
        return Int(image.size.height * image.size.width * image.scale * image.scale)
    }
}
