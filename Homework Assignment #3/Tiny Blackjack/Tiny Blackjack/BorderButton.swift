//
//  BorderButton.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 08/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

// A button with a single border
@IBDesignable class BorderButton: UIButton {
   
   @IBInspectable var borderColor: UIColor = UIColor.white {
      didSet {
         layer.borderColor = borderColor.cgColor
      }
   }
   
   @IBInspectable var borderWidth: CGFloat = 2.0 {
      didSet {
         layer.borderWidth = borderWidth
      }
   }
   
   override public func layoutSubviews() {
      super.layoutSubviews()
      clipsToBounds = true
   }
}
