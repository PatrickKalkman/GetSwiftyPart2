//
//  UiViewExtensions.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 14/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // When hiding UI elements, we let them fade in or out
    func hideWithAnimation(hidden: Bool) {
        UIView.transition(with: self, duration: 1, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }
    
    // When changing text on a label we use this to fade in/out the text
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
