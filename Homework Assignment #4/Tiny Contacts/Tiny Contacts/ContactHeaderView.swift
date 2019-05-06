//
//  ContactHeaderView.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 05/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

class ContactHeaderView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    
    var headerTitle: String! {
        didSet {
            headerLabel.text = headerTitle
        }
    }
}
