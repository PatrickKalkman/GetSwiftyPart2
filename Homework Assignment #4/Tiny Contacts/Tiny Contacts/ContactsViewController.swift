//
//  ViewController.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 05/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import FontAwesome_swift
import CoreData

class ContactsViewController: UIViewController {

    private let contactGenerator: ContactDataGenerator = ContactDataGenerator()
    private var blockOperations: [BlockOperation] = []
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var fetchResultController: NSFetchedResultsController<Contact>!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var searchQueryText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.setTextFieldColor(color: UIColor.lightGray.withAlphaComponent(0.3))
        searchBar.setTextColor(color: UIColor.darkGray)
        searchBar.layer.borderWidth = 1;
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.delegate = self
        
        let width: CGFloat = (view.frame.size.width - 50) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    @IBAction func addContact() {
        let generatedContact = contactGenerator.generateRandomContact()
        context.insert(generatedContact)
        appDelegate.saveContext()
    }
    
    func refresh() {
        let request = Contact.fetchRequest() as NSFetchRequest<Contact>
        if !searchQueryText.isEmpty {
            request.predicate = NSPredicate(format: "firstname CONTAINS[cd] %@", searchQueryText)
        }
        let sort = NSSortDescriptor(key: #keyPath(Contact.firstname), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        let group = NSSortDescriptor(key: #keyPath(Contact.group), ascending: true)
        request.sortDescriptors = [group, sort]
        do {
            fetchResultController = NSFetchedResultsController(fetchRequest: request,
                    managedObjectContext: context, sectionNameKeyPath: #keyPath(Contact.group), cacheName: nil)
            fetchResultController.delegate = self
            try fetchResultController.performFetch()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchResultController.sections, let contacts = sections[section].objects else {
            return 0
        }
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell", for: indexPath)
        if let contactViewCell = cell as? ContactViewCell {
            
            let contact: Contact = fetchResultController.object(at: indexPath)
            if let firstName = contact.firstname {
                contactViewCell.firstNameLabel.text = firstName
            }
            if let lastName = contact.lastname {
                contactViewCell.lastNameLabel.text = lastName
            } else {
                contactViewCell.lastNameLabel.text = ""
            }
            
            contactViewCell.callButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 10, style: .solid)
            contactViewCell.callButton.setTitle(String.fontAwesomeIcon(name: .phone), for: .normal)
            contactViewCell.callButton.layer.cornerRadius = 3
            contactViewCell.callButton.clipsToBounds = true

            contactViewCell.mailButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 10, style: .solid)
            contactViewCell.mailButton.setTitle(String.fontAwesomeIcon(name: .envelope), for: .normal)
            contactViewCell.mailButton.layer.cornerRadius = 3
            contactViewCell.mailButton.clipsToBounds = true
            
            contactViewCell.faceTimeButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 10, style: .solid)
            contactViewCell.faceTimeButton.setTitle(String.fontAwesomeIcon(name: .video), for: .normal)
            contactViewCell.faceTimeButton.layer.cornerRadius = 3
            contactViewCell.faceTimeButton.clipsToBounds = true
            
            contactViewCell.textButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 10, style: .solid)
            contactViewCell.textButton.setTitle(String.fontAwesomeIcon(name: .comment), for: .normal)
            contactViewCell.textButton.layer.cornerRadius = 3
            contactViewCell.textButton.clipsToBounds = true
            
            contactViewCell.payButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 10, style: .solid)
            contactViewCell.payButton.setTitle(String.fontAwesomeIcon(name: .dollarSign), for: .normal)
            contactViewCell.payButton.layer.cornerRadius = 3
            contactViewCell.payButton.clipsToBounds = true
            
            return contactViewCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                    withReuseIdentifier: "ContactHeaderView", for: indexPath) as! ContactHeaderView
        
        if let contacts = fetchResultController.sections?[indexPath.section].objects as? [Contact], let contact = contacts.first {
            sectionHeaderView.headerTitle = contact.group
        }
        
        return sectionHeaderView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
}

extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQueryText = searchText
        refresh()
        collectionView.reloadData()
    }
}

// Fetch controller delegate
extension ContactsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        blockOperations.removeAll(keepingCapacity: true)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        let index = indexPath ?? (newIndexPath ?? nil)
        guard let cellIndex = index else {
            return
        }
        
        var op: BlockOperation  = BlockOperation { }
        switch type {
        case .insert:
            op = BlockOperation { self.collectionView.insertItems(at: [cellIndex]) }
        case .delete:
            op = BlockOperation { self.collectionView.deleteItems(at: [cellIndex]) }
        default:
            break;
        }
        
        blockOperations.append(op)
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        var op: BlockOperation = BlockOperation { }
        let sectionIndexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            op = BlockOperation { self.collectionView.insertSections(sectionIndexSet) }
        case .delete:
            op = BlockOperation { self.collectionView.deleteSections(sectionIndexSet) }
        default:
            break;
        }
        blockOperations.append(op)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({
            self.blockOperations.forEach({ $0.start() })
            }, completion: {(finished) in
                self.blockOperations.removeAll(keepingCapacity: false)
            })
    }
}
