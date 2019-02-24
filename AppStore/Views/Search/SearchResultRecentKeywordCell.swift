//
//  SearchResultRecentKeywordCell.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import UIKit

class SearchResultRecentKeywordCell: UITableViewCell, KKBCellProtocol {
    @IBOutlet var selectionView     : UIView?
    @IBOutlet var titleLabel        : UILabel?
    
    func configure(_ data: (model: SearchKeywordModel2, keyword: String)) {
        let model       = data.model
        let keyword     = data.keyword
        let title = NSMutableAttributedString(string: model.term)
        title.setFont(.systemFont(ofSize: 17, weight: .regular), text: keyword)
        self.titleLabel?.attributedText = title
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.selectionView?.backgroundColor = highlighted ? .lightGray : .clear
        self.titleLabel?.isHighlighted = highlighted
    }
}
