//
//  FlowLayout.swift
//  AppStore
//
//  Created by Kim JungMoo on 29/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit

class KKBItemPageFlowLayout: UICollectionViewFlowLayout {
    let flickVelocity: CGFloat = 0.3
    
    var pageWidth: CGFloat {
        return self.itemSize.width + self.minimumLineSpacing
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero}
        var proposedContentOffset = proposedContentOffset
        
        let rawPageValue    = collectionView.contentOffset.x / self.pageWidth
        let currentPage     = (velocity.x > 0.0) ? floor(rawPageValue)  : ceil(rawPageValue)
        let nextPage        = (velocity.x > 0.0) ? ceil(rawPageValue)   : floor(rawPageValue)

        let pannedLessThanPage = abs(1 + currentPage - rawPageValue) > 0.5
        let flicked = abs(velocity.x) > self.flickVelocity
        
        if pannedLessThanPage && flicked {
            proposedContentOffset.x = nextPage * self.pageWidth
        } else {
            proposedContentOffset.x = round(rawPageValue) * self.pageWidth
        }
        return proposedContentOffset
    }
}
