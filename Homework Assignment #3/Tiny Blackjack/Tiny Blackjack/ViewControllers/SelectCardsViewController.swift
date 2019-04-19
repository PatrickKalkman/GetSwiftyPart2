//
//  SelectCardsViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 19/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

class SelectCardsViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    private var hearts: [Card] = [Card]()
    private var diamonds: [Card] = [Card]()
    private var clubs: [Card] = [Card]()
    private var spades: [Card] = [Card]()
    
    private let reuseIdentifier = "CardCell"
    private let cardToImageNameMapper: CardToImageNameMapper = CardToImageNameMapper()
    
    @IBOutlet weak var heartsCollectionView: UICollectionView!
    @IBOutlet weak var clubsCollectionView: UICollectionView!
    @IBOutlet weak var diamondsCollectionView: UICollectionView!
    @IBOutlet weak var spadesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCards()
        heartsCollectionView.delegate = self
        clubsCollectionView.delegate = self
        diamondsCollectionView.delegate = self
        spadesCollectionView.delegate = self
        heartsCollectionView.reloadData()
        clubsCollectionView.reloadData()
        diamondsCollectionView.reloadData()
        spadesCollectionView.reloadData()
    }
    
    func createCards() {
        var cardIndex: Int = 1
        for rank in Rank.allCases {
            hearts.append(Card(Suit.heart, rank, cardIndex))
            cardIndex += 1
            diamonds.append(Card(Suit.diamond, rank, cardIndex))
            cardIndex += 1
            clubs.append(Card(Suit.club, rank, cardIndex))
            cardIndex += 1
            spades.append(Card(Suit.spade, rank, cardIndex))
            cardIndex += 1
        }
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hearts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var card: Card
            
        if collectionView == heartsCollectionView {
            card = hearts[indexPath.item]
        } else if collectionView == clubsCollectionView {
            card = clubs[indexPath.item]
        } else if collectionView == diamondsCollectionView {
            card = diamonds[indexPath.item]
        } else {
            card = spades[indexPath.item]
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let myCell = cell as? CardSelectCollectionViewCell {
            
            let imageName: String = cardToImageNameMapper.map(card)
            myCell.Image.image = UIImage(named: imageName)
            myCell.card = card
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 94, height: 120)
    }
    

}
