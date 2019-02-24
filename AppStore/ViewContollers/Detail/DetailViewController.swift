//
//  DetailViewController.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class DetailViewController: KKBViewController {
    override var viewModel              : DetailViewModel { return self.connector.getViewModel(type: DetailViewModel.self) }

    @IBOutlet var titleIconImageView    : UIImageView?
    @IBOutlet var titleOpenButton       : UIButton?
    @IBOutlet var stackView             : UIStackView?
    @IBOutlet var basicInfoView         : DetailBasicInfoView?
    @IBOutlet var screenshotView        : DetailScreenshotView?
    @IBOutlet var descriptionView       : DetailDescriptionView?
    @IBOutlet var releaseInfoView       : DetailReleaseInfoView?
    @IBOutlet var developerView         : DetailDeveloperView?
    @IBOutlet var extraInfoView         : DetailExtraInfoView?
    
    var isHiddenTitleView               : Bool       = true
    
    var appInfo: SoftwareModel? {
        set { self.viewModel.appInfo.accept(newValue) }
        get { return self.viewModel.appInfo.value }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initAppInfoObservable()
        self.initNavigationBar()
    }
    
    func initAppInfoObservable() {
        self.viewModel.appInfo.distinctUntilChanged().bind { [weak self] appInfo in
            guard let appInfo = appInfo else { return }
            self?.configureTitleIcon(appInfo)
            
            self?.basicInfoView?.configure(appInfo)
            self?.screenshotView?.configure(appInfo)
            self?.descriptionView?.configure(appInfo)
            self?.releaseInfoView?.configure(appInfo)
            self?.extraInfoView?.configure(appInfo)
            self?.raiseReleaseInfo()
            
        }.disposed(by: self.disposeBag)
    }
    
    func initNavigationBar() {
        if let titleIconImageView = self.titleIconImageView {
            self.navigationItem.titleView = titleIconImageView
        }
        
        if let titleOpenButton = self.titleOpenButton {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleOpenButton)
        }
    }
    
    func configureTitleIcon(_ data: SoftwareModel) {
        guard let titleIconImageView = self.titleIconImageView else { return }
        let url = URL(string: data.artworkUrl60)
        KKBImageLoader.default.setImageView(titleIconImageView, url: url) { (_, _, cacheType) in
            guard cacheType != .memory else { return }
            titleIconImageView.startAlphaAnimating()
        }
    }
    
    func raiseReleaseInfo() {
        guard let stackView = self.stackView else { return }
        guard let releaseInfoView = self.releaseInfoView else { return }
        stackView.removeArrangedSubview(releaseInfoView)
        stackView.insertArrangedSubview(releaseInfoView, at: 1)
        stackView.layoutIfNeeded()
        self.screenshotView?.startAnimating()
    }
    
    @IBAction func actionTouchUpInsideOpen(_ sender: Any?) {
        guard let appInfo = self.appInfo else { return }
        URL(string: appInfo.trackViewUrl)?.openWithSafari()
    }
    
    @IBAction func actionTouchUpInsideShare(_ sender: Any?) {
        guard let appInfo = self.appInfo else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [appInfo.trackViewUrl], applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
}

extension DetailViewController {
    func showTitleView() {
        guard let titleIconImageView = self.titleIconImageView else { return }
        guard let titleOpenButton = self.titleOpenButton else { return }
        guard self.isHiddenTitleView else { return }
        
        self.isHiddenTitleView = false
        self.showTitleViewAnimation(titleIconImageView)
        self.showTitleViewAnimation(titleOpenButton)
    }
    
    func hideTitleView() {
        guard let titleIconImageView = self.titleIconImageView else { return }
        guard let titleOpenButton = self.titleOpenButton else { return }
        guard !self.isHiddenTitleView else { return }
        
        self.isHiddenTitleView = true
        self.hideTitleViewAnimation(titleIconImageView)
        self.hideTitleViewAnimation(titleOpenButton)
    }
    
    func showTitleViewAnimation(_ view: UIView) {
        view.isHidden = false
        view.alpha = 0.0
        view.transform.ty = 5
        UIView.animate(withDuration: 0.3) {
            view.alpha = 1.0
            view.transform.ty = 0
        }
    }
    
    func hideTitleViewAnimation(_ view: UIView) {
        view.isHidden = false
        view.alpha = 1.0
        view.transform.ty = 0
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
            view.transform.ty = 5
        }, completion: { _ in
            view.isHidden = true
        })
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 100 {
            self.showTitleView()
        } else {
            self.hideTitleView()
        }
    }
}
