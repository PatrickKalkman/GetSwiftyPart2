//
//  FlowLayout.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 15/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {

    var addedItem: IndexPath?
    var itemToDelete: [IndexPath]?
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath), let added = addedItem, added == itemIndexPath else {
            return nil
        }
        
        attributes.center = CGPoint(x: collectionView!.frame.width - 23.5, y: -24.5)
        attributes.alpha = 1.0
        attributes.transform = CGAffineTransform(scaleX: 0.15, y: 0.15)
        attributes.zIndex = 5
        
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath), let deleted = itemToDelete, deleted.contains(itemIndexPath) else {
            return nil
        }
        
        attributes.alpha = 1.0
        attributes.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        attributes.zIndex = -1
        
        return attributes
    }
    
}
