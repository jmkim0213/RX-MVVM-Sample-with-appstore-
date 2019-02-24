//
//  Error+Alert.swift
//  AppStore
//
//  Created by Kim JungMoo on 28/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

extension Error {
    func showAlert(_ title: String? = "") {
        Alert(title: title, message: self.localizedDescription)
            .addAction("확인", style: .default).show()
    }
}
