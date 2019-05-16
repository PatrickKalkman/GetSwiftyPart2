//
//  ContactViewCell.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 06/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

class ContactViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var faceTimeButton: UIButton!
    @IBOutlet weak var mailButton: UIButton!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var selectionImage: UIImageView!
    
    var isEditing: Bool = false {
        didSet {
            selectionImage.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectionImage.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
            }
        }
    }
}
