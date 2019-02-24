//
//  KKBViewModelConnector.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation

class KKBViewModelConnector {
    private var _viewModel: KKBViewModel?    = nil
    
    func getViewModel<T: KKBViewModel>(type : T.Type) -> T {
        if let viewModel = self._viewModel as? T {
            return viewModel
        } else {
            let viewModel = T()
            self._viewModel = viewModel
            return viewModel
        }
    }
}
