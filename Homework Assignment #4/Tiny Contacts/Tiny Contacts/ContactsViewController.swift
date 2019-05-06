//
//  ViewController.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 05/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ContactsViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var collectionData = ["1 Patrick", "2 Frank", "3 Christina", "4 Gretha", "5 Tara", "6 Vionne"]
    
    var categories = ["Favorites", "Top people", "Business"]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.setTextFieldColor(color: UIColor.lightGray.withAlphaComponent(0.3))
        searchBar.setTextColor(color: UIColor.darkGray)
        searchBar.layer.borderWidth = 1;
        searchBar.layer.borderColor = UIColor.white.cgColor
        
        let width: CGFloat = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
    }
    
}


extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("section \(section)")
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell", for: indexPath)
            
        if let contactViewCell = cell as? ContactViewCell {
            if let label = contactViewCell.viewWithTag(100) as? UILabel {
                label.text = collectionData[indexPath.row]
            }

            contactViewCell.callButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 12, style: .solid)
            contactViewCell.callButton.setTitle(String.fontAwesomeIcon(name: .phone), for: .normal)
            contactViewCell.callButton.layer.cornerRadius = 8
            contactViewCell.callButton.clipsToBounds = true
            
            contactViewCell.mailButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 12, style: .solid)
            contactViewCell.mailButton.setTitle(String.fontAwesomeIcon(name: .envelope), for: .normal)
            contactViewCell.mailButton.layer.cornerRadius = 8
            contactViewCell.mailButton.clipsToBounds = true
            
            contactViewCell.faceTimeButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 12, style: .solid)
            contactViewCell.faceTimeButton.setTitle(String.fontAwesomeIcon(name: .video), for: .normal)
            contactViewCell.faceTimeButton.layer.cornerRadius = 8
            contactViewCell.faceTimeButton.clipsToBounds = true
            
            contactViewCell.textButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 12, style: .solid)
            contactViewCell.textButton.setTitle(String.fontAwesomeIcon(name: .comment), for: .normal)
            contactViewCell.textButton.layer.cornerRadius = 8
            contactViewCell.textButton.clipsToBounds = true
            
            contactViewCell.payButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 12, style: .solid)
            contactViewCell.payButton.setTitle(String.fontAwesomeIcon(name: .dollarSign), for: .normal)
            contactViewCell.payButton.layer.cornerRadius = 8
            contactViewCell.payButton.clipsToBounds = true
            
            return contactViewCell
        }
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContactHeaderView", for: indexPath) as! ContactHeaderView
        
        let category: String = categories[indexPath.section]
        
        sectionHeaderView.headerTitle = category
        
        return sectionHeaderView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
}
