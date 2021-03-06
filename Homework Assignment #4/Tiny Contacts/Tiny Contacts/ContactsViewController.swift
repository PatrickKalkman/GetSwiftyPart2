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
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!

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

        navigationItem.leftBarButtonItem = editButtonItem
        navigationController?.toolbar.isHidden = true
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing

        collectionView.indexPathsForSelectedItems?.forEach({
            collectionView.deselectItem(at: $0, animated: false)
        })

        addButton.isEnabled = !editing
        deleteButton.isEnabled = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! ContactViewCell
            cell.isEditing = editing
        }
        deleteButton.isEnabled = isEditing
        if !editing {
            navigationController?.toolbar.isHidden = true
        } else {
            navigationController?.toolbar.isHidden = false
        }
    }

    @IBAction func addContact() {
        // This generates a random contact from random data
        let generatedContact: Contact = contactGenerator.generateRandomContact(context: context)
        appDelegate.saveContext()

        let phone1: Phone = contactGenerator.generatePhone(type: "work", context: context)
        phone1.phoneOwner = generatedContact
        let phone2: Phone = contactGenerator.generatePhone(type: "private", context: context)
        phone2.phoneOwner = generatedContact

        let email1: Email = contactGenerator.generateEmail(type: "work", context: context)
        email1.emailOwner = generatedContact
        let email2: Email = contactGenerator.generateEmail(type: "private", context: context)
        email2.emailOwner = generatedContact
        appDelegate.saveContext()
    }

    @IBAction func editButtonPressed(_ sender: Any) {
        setEditing(true, animated: true)
    }

    @IBAction func deleteButtonPressed(_ sender: Any) {
        if let selectedItems: [IndexPath] = collectionView.indexPathsForSelectedItems {
            let layout = self.collectionView?.collectionViewLayout as! FlowLayout
            layout.itemToDelete = selectedItems
            for indexPath in selectedItems {
                let contactToDelete: Contact = fetchResultController.object(at: indexPath)
                context.delete(contactToDelete)
            }
            appDelegate.saveContext()
        }
        setEditing(false, animated: true)
    }

    func loadData() {
        let request = Contact.fetchRequest() as NSFetchRequest<Contact>
        if !searchQueryText.isEmpty {
            request.predicate = NSPredicate(format: "firstname CONTAINS[cd] %@", searchQueryText)
        }
        let sort = NSSortDescriptor(key: #keyPath(Contact.firstname), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        let group = NSSortDescriptor(key: #keyPath(Contact.group), ascending: true)
        request.sortDescriptors = [group, sort]
        do {
            fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: #keyPath(Contact.group), cacheName: nil)
            fetchResultController.delegate = self
            try fetchResultController.performFetch()
        } catch let error as NSError {
            print("Could not fetch the contact data. \(error), \(error.userInfo)")
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Only move to detail screen when we are not in editing mode
        return !isEditing
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let contactViewCell = sender as? ContactViewCell {
            if let indexPathForContactViewCell = collectionView.indexPath(for: contactViewCell) {
                let selectedContact: Contact = fetchResultController.object(at: indexPathForContactViewCell)
                if let destination = segue.destination as? ContactDetailViewController {
                    destination.selectedContact = selectedContact
                }
            }
        }
    }

}

// Collectionview delegate and datasource
extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchResultController.sections, let contacts = sections[section].objects else {
            return 0
        }

        return contacts.count
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            navigationController?.toolbar.isHidden = false
            if let selected = collectionView.indexPathsForSelectedItems, selected.count == 0 {
                navigationController?.toolbar.isHidden = true
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell", for: indexPath)
        if let contactViewCell = cell as? ContactViewCell {
            let contact: Contact = fetchResultController.object(at: indexPath)
            contactViewCell.firstNameLabel.text = contact.firstname
            contactViewCell.lastNameLabel.text = contact.lastname
            setCellButtons(contactViewCell: contactViewCell)
            contactViewCell.isEditing = isEditing
            return contactViewCell
        }

        return cell
    }

    func setCellButtons(contactViewCell: ContactViewCell) {
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
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
            withReuseIdentifier: "ContactHeaderView", for: indexPath) as! ContactHeaderView

        if let sections = fetchResultController.sections, sections.count > indexPath.section {
            if let contacts = fetchResultController.sections?[indexPath.section].objects as? [Contact], let contact = contacts.first {
                sectionHeaderView.headerTitle = contact.group
            }
        }

        return sectionHeaderView
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
}

// Searchbar delegate
extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQueryText = searchText
        loadData()
        collectionView.reloadData()
    }
}

// Delegate that gets called when contacts data changes
extension ContactsViewController: NSFetchedResultsControllerDelegate {

    // All the changes are batched and performed in one go (section, contacts). Otherwise, the collectionview
    // reports problems.

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        blockOperations.removeAll(keepingCapacity: true)
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        let index = indexPath ?? (newIndexPath ?? nil)
        guard let cellIndex = index else {
            return
        }

        var blockOperation: BlockOperation = BlockOperation { }
        switch type {
        case .insert:
            blockOperation = BlockOperation {
                let layout = self.collectionView?.collectionViewLayout as! FlowLayout
                layout.addedItem = cellIndex
                self.collectionView.insertItems(at: [cellIndex])
            }
        case .delete:
            blockOperation = BlockOperation {
                self.collectionView.deleteItems(at: [cellIndex])
            }
        case .update:
            blockOperation = BlockOperation {
                self.collectionView.reloadItems(at: [cellIndex])
            }
        case .move:
            blockOperation = BlockOperation {
                self.collectionView.moveItem(at: index!, to: newIndexPath!)
            }
        default:
            break;
        }

        blockOperations.append(blockOperation)
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {

        var blockOperation: BlockOperation = BlockOperation { }
        let sectionIndexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            blockOperation = BlockOperation { self.collectionView.insertSections(sectionIndexSet) }
        case .delete:
            blockOperation = BlockOperation { self.collectionView.deleteSections(sectionIndexSet) }
        case .update:
            blockOperation = BlockOperation { self.collectionView?.reloadSections(sectionIndexSet) }
        default:
            break;
        }
        blockOperations.append(blockOperation)
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({
            self.blockOperations.forEach({ $0.start() })
        }, completion: { (finished) in
                self.blockOperations.removeAll(keepingCapacity: false)
            })
    }
}
