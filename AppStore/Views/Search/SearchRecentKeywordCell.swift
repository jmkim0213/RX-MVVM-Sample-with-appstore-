//
//  SearchRecentKeywordCell.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

class SearchRecentKeywordCell: UITableViewCell, KKBCellProtocol {
    @IBOutlet var selectionView     : UIView?
    @IBOutlet var titleLabel        : UILabel?
    
    func configure(_ data: SearchKeywordModel2) {
        self.titleLabel?.text = data.term
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.selectionView?.backgroundColor = highlighted ? self.titleLabel?.textColor : .clear
        self.titleLabel?.isHighlighted = highlighted
    }
}
