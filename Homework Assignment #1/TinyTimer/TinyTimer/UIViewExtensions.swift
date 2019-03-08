//
//  UiViewExtensions.swift
//  TinyTimer
//
//  Created by Patrick Kalkman on 08/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
   func hideWithAnimation(hidden: Bool) {
      UIView.transition(with: self, duration: 1, options: .transitionCrossDissolve, animations: {
         self.isHidden = hidden
      })
   }
   
   func fadeTransition(_ duration:CFTimeInterval) {
      let animation = CATransition()
      animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
      animation.type = CATransitionType.fade
      animation.duration = duration
      layer.add(animation, forKey: CATransitionType.fade.rawValue)
   }
   
}
