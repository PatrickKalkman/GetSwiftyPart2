//
//  TipInCellAnimator.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 15/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

let tipInCellAnimatorStartTransform: CATransform3D = {
    let rotationDegrees: CGFloat = -45.0
    let rotationRadians: CGFloat = rotationDegrees * (CGFloat(Double.pi) / 180.0)
    let offset = CGPoint(x: -30, y: -30)
    var startTransform = CATransform3DIdentity
    startTransform = CATransform3DRotate(CATransform3DIdentity,
        rotationRadians, 0.0, 0.0, 1.0)
    startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)

    return startTransform
}()

class TipInCellAnimator {
    class func animate(cell: UITableViewCell) {
        let view = cell.contentView

        view.layer.transform = tipInCellAnimatorStartTransform
        view.layer.opacity = 0.8

        UIView.animate(withDuration: 0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
}
