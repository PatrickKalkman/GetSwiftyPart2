//
//  DropDownButton.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 14/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

class DropDownButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setImage(UIImage(named: "icons8-pull-down-filled-50"), for: .normal )
        
        sizeToFit()
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageRect(forContentRect: bounds).width - 17.0, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: -2, right: 0)
    }
}
