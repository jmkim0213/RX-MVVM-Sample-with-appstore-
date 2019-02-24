//
//  KKBCellProtocol.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

protocol KKBAnyCellProtocol {
    func _configure(_ data: Any?)
}

protocol KKBCellProtocol: KKBAnyCellProtocol {
    associatedtype DataType
    func configure(_ data: DataType)
}

extension KKBCellProtocol {
    func _configure(_ data: Any?) {
        guard let data = data as? DataType else { return }
        self.configure(data)
    }
}

extension UITableView {
    func configuredCell(_ cellType: KKBCellTypeProtocol, for indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        (cell as? KKBAnyCellProtocol)?._configure(cellType.data)
        return cell
    }
}

extension UICollectionView {
    func configuredCell(_ cellType: KKBCellTypeProtocol, for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath)
        (cell as? KKBAnyCellProtocol)?._configure(cellType.data)
        return cell
    }
}
