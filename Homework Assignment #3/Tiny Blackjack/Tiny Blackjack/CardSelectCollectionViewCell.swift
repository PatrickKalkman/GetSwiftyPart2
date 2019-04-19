//
//  CardSelectTableViewCell.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 19/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

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
                    self.Image.transform = .init(scaleX: 0.95, y: 0.95)
                    self.contentView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
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
