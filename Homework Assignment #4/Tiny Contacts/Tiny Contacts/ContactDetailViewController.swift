//
//  ContactDetailViewController.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 16/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import CoreData
import RSSelectionMenu

class ContactDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var GroupButton: UIButton!
    @IBOutlet weak var PhoneTableView: UITableView!
    
    private var groupData: [String] = [String]()
    
    var selectedContact: Contact?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupData = ["Favorites", "Family", "Work", "Other"]
        navigationController?.toolbar.isHidden = false
                
        PhoneTableView.delegate = self
        PhoneTableView.dataSource = self
        
        if let loadedContact = selectedContact {
            FirstName.text = loadedContact.firstname
            LastName.text = loadedContact.lastname
            GroupButton.setTitle(loadedContact.group, for: UIControl.State.normal)
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        if let contactToUpdate = selectedContact {
            contactToUpdate.firstname = FirstName.text
            contactToUpdate.lastname = LastName.text
            contactToUpdate.group = GroupButton.titleLabel?.text
            appDelegate.saveContext()
            
            if let cell = PhoneTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? PhoneTableViewCell {
                if let phone = contactToUpdate.phones?.allObjects[0] as? Phone {
                    phone.phone = cell.phoneNumberTextField.text
                    phone.type = cell.typeOfPhoneButton.titleLabel?.text
                    appDelegate.saveContext()
                }
            }
            
            navigationController?.toolbar.isHidden = true
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func showGroupMenu(_ sender: Any) {
        
        let menu = RSSelectionMenu(dataSource: groupData) { (cell, name, indexPath) in
            cell.textLabel?.text = name
        }
        
        var selectedNames: [String] = [String]()
        if let contact = selectedContact {
            if let group = contact.group {
                selectedNames.append(group)
            }
        }

        menu.setSelectedItems(items: selectedNames) { (name, index, selected, selectedItems) in
            self.GroupButton.setTitle(name, for: UIControl.State.normal)
        }
        
        menu.show(style: .formSheet,from: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let contact = selectedContact {
                if let phones = contact.phones {
                    return phones.count
                }
            }
            return 0
        }
        if section == 1 {
            if let contact = selectedContact {
                if let emails = contact.emails {
                    return emails.count
                }
            }
            return 0
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell", for: indexPath)
        
        if let phoneTableViewCell = cell as? PhoneTableViewCell {
            phoneTableViewCell.parentViewController = self
            if let contact = selectedContact {
                if indexPath.section == 0 {
                    if let contactPhones = contact.phones?.allObjects {
                        if let contactPhone = contactPhones[indexPath.item] as? Phone {
                            phoneTableViewCell.phoneNumberTextField.text = contactPhone.phone
                            phoneTableViewCell.typeOfPhoneButton.setTitle(contactPhone.type, for: UIControl.State.normal)
                        }
                    }
                } else if indexPath.section == 1 {
                    if let contactEmails = contact.emails?.allObjects {
                        if let contactEmail = contactEmails[indexPath.item] as? Email {
                            phoneTableViewCell.phoneNumberTextField.text = contactEmail.email
                            phoneTableViewCell.typeOfPhoneButton.setTitle(contactEmail.type, for: UIControl.State.normal)
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Phone"
        } else if section == 1 {
            return "Email"
        }
        return ""
    }
    

}
