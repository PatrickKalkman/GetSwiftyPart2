//
//  ContactDetailViewController.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 16/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import RSSelectionMenu

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var GroupButton: UIButton!
    
    private var groupData: [String] = [String]()
    
    var selectedContact: Contact?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupData = ["Favorites", "Family", "Work", "Other"]
        
        navigationController?.toolbar.isHidden = false
        
        if let contact = selectedContact {
            FirstName.text = contact.firstname
            LastName.text = contact.lastname
            GroupButton.setTitle(contact.group, for: UIControl.State.normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
	    }
    
    @IBAction func showGroupMenu(_ sender: Any) {
        
        let menu = RSSelectionMenu(dataSource: groupData) { (cell, name, indexPath) in
            cell.textLabel?.text = name
        }
        // provide selected items
//        menu.setSelectedItems(items: selectedNames) { (name, index, selected, selectedItems) in
//            selectedNames = selectedItems
//        }
        // show - Present
        menu.show(from: self)
    }
    

}
