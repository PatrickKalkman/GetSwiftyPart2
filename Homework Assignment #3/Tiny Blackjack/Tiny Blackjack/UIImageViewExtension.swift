//
//  UIImageViewExtension.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 04/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//
import UIKit

extension UIImageView {

    func setOrigin(_ originToSet: CGPoint) {
        self.frame.origin = originToSet
    }
    
    func moveXY(_ toMoveX: CGFloat, _ toMoveY: CGFloat) {
        self.frame.origin.x += toMoveX
        self.frame.origin.y += toMoveY
    }
    
    func moveX(_ toMoveX: CGFloat) {
        self.frame.origin.x += toMoveX
    }
    
    func moveToXDeltaY(_ toX: CGFloat, _ toMoveY: CGFloat) {
        self.frame.origin.x = toX
        self.frame.origin.y += toMoveY
    }

}

extension UILabel {

    func setOrigin(_ originToSet: CGPoint) {
        self.frame.origin = originToSet
    }

}
