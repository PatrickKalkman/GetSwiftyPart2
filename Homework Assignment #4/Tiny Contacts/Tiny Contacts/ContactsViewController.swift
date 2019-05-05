//
//  ViewController.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 05/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.setTextFieldColor(color: UIColor.lightGray.withAlphaComponent(0.3))
        searchBar.setTextColor(color: UIColor.darkGray)
        searchBar.layer.borderWidth = 1;
        searchBar.layer.borderColor = UIColor.white.cgColor

    }
    
}

