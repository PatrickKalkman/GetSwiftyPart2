//
//  CardSelectTableViewCell.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 19/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class CardSelectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Image: UIImageView!
    var card: Card!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                UIView.animate(withDuration: 0.1) {
                    self.Image.transform = .init(scaleX: 0.9, y: 0.9)
                    self.contentView.backgroundColor = UIColor.init(hex: "#58CB70FF")
                }
            }
            else
            {
                UIView.animate(withDuration: 0.1) {
                    self.Image.transform = .identity
                    self.contentView.backgroundColor = .clear
                }
            }
        }
    }

}
