//
//  UIViewExtensions.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 12/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
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

extension UIView {
    func shake(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
            ( degrees: Double) -> Double in
            let radians: Double = (.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
}

extension UILabel {
    
    func setOrigin(_ originToSet: CGPoint) {
        self.frame.origin = originToSet
    }
    
}
