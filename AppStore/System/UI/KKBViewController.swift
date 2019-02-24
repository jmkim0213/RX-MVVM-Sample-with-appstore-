//
//  KKBViewController.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit
import RxSwift

class KKBViewController: UIViewController {
    let disposeBag      : DisposeBag                = DisposeBag()
    let connector       : KKBViewModelConnector     = KKBViewModelConnector()
    var viewModel       : KKBViewModel { return self.connector.getViewModel(type: KKBViewModel.self) }
}
