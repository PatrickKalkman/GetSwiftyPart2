//
//  PhoneTableViewCell.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 16/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import RSSelectionMenu

class PhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var typeOfPhoneButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var parentViewController: UIViewController?
    
    private var typeData: [String] = ["work", "private"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func typeOfPhoneTapped(_ sender: Any) {
        let menu = RSSelectionMenu(dataSource: typeData) { (cell, name, indexPath) in
            cell.textLabel?.text = name
        }
        
        var selectedNames: [String] = [String]()
        selectedNames.append((typeOfPhoneButton.titleLabel?.text!)!)
        
        menu.setSelectedItems(items: selectedNames) { (name, index, selected, selectedItems) in
            self.typeOfPhoneButton.setTitle(name, for: UIControl.State.normal)
        }
        
        menu.show(style: .formSheet,from: parentViewController!)
    }
}
