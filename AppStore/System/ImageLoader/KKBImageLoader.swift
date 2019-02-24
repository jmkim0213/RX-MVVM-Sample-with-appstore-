//
//  ImageLoader.swift
//  AppStore
//
//  Created by Kim JungMoo on 28/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

typealias KKBImageCompletion = (UIImage?, Error?, KKBImageCacheType) -> Void

enum KKBImageCacheType {
    case none
    case disk
    case memory
}

class KKBImageLoader {
    static let `default`: KKBImageLoader = {
        return KKBImageLoader()
    }()
    
    let disposeBag      : DisposeBag        = DisposeBag()
    var urlMap          : [Int:URL]         = [:]
    var disposableQueue : [URL:Disposable]  = [:]
    let scheduler       : SchedulerType     = ConcurrentDispatchQueueScheduler(queue: DispatchQueue(label: "KKBImageLoader"))
    
    let imageCache      : KKBImageCache     = KKBImageCache.default
    
    func setImageView(_ imageView: UIImageView, url: URL?, completion: @escaping KKBImageCompletion) {
        guard let imagePath = self.getImagePath(url: url) else { return }
        
        imageView.image = nil
        self.cancel(hash: imageView.hash)
        self.cancel(url: url)
        
        if let image = self.imageCache.retrieveImage(url: url) {
            imageView.image = image
            completion(image, nil, .memory)
        } else {
            var observer    : Observable<UIImage?> = Observable.empty()
            var cacheType   : KKBImageCacheType = .none
            if FileManager.default.fileExists(atPath: imagePath) {
                observer = self.loadImageFromDisk(url: url)
                cacheType = .disk
                
            } else {
                observer = self.loadImageFromNetwork(url: url)
                cacheType = .none
            }
            
            let disposable = observer.subscribe(onNext: { [weak self] image in
                imageView.image = image
                if let image = image { self?.imageCache.addCache(url: url, image: image) }
                completion(image, nil, cacheType)
            }, onError: { error in
                imageView.image = nil
                completion(nil, error, cacheType)
            }, onCompleted: { [weak self] in
                self?.cancel(url: url)
            })
            
            // 작업 더하기
            self.addQueue(hash: imageView.hash, url: url, disposable: disposable)
        }
    }
}

// Queue
extension KKBImageLoader {
    private func addQueue(hash: Int, url: URL?, disposable: Disposable?) {
        guard let url = url else { return }
        self.urlMap[hash] = url
        self.disposableQueue[url] = disposable
    }
    
    private func cancel(hash: Int, url: URL?) {
        self.cancel(hash: hash)
        self.cancel(url: url)
    }
    
    private func cancel(hash: Int) {
        guard let url = self.urlMap[hash] else { return }
        guard let disposable = self.disposableQueue.removeValue(forKey: url) else { return }
        disposable.dispose()
    }
    
    private func cancel(url: URL?) {
        guard let url = url else { return }
        guard let disposable = self.disposableQueue.removeValue(forKey: url) else { return }
        disposable.dispose()
    }
}

// Load Network
extension KKBImageLoader {
    func loadImageFromNetwork(url: URL?) -> Observable<UIImage?> {
        return Observable.from(optional: url)
        .map { URLRequest(url: $0) }
        .flatMap { URLSession.shared.rx.response(request: $0).retry(3) }
        .map { _, data -> UIImage? in
            UIImage(data: data)
        }
        .map { image -> UIImage? in
            self.saveImage(image: image, url: url)
            return image
        }
        .take(1)
        .subscribeOn(self.scheduler)
        .observeOn(MainScheduler.instance)
    }
}

// Load Disk
extension KKBImageLoader {
    private func loadImageFromDisk(url: URL?) -> Observable<UIImage?> {
        return Observable.from(optional: self.getImagePath(url: url))
        .map { try? Data(contentsOf: URL(fileURLWithPath: $0)) }
        .map { data -> UIImage? in
            guard let data = data else { return nil }
            return UIImage(data: data)
        }
        .take(1)
        .subscribeOn(self.scheduler)
        .observeOn(MainScheduler.instance)
    }
    
    private func saveImage(image: UIImage?, url: URL?) {
        guard let image = image else { return }
        guard let imagePath = self.getImagePath(url: url) else { return }
        try? image.jpegData(compressionQuality: 1.0)?.write(to: URL(fileURLWithPath: imagePath), options: .atomicWrite)
    }
    
    private func getImagePath(url: URL?) -> String? {
        guard let url = url else { return nil }
        let imageName = "\(url.hashValue).jpg"
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return nil }
        return "\(documentsPath)/\(imageName)"
    }
}
