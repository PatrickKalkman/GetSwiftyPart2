//
//  SelectCardsViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 19/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift

class SelectCardsViewController : BlackjackViewControllerBase, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
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
        heartsCollectionView.allowsMultipleSelection = true
        clubsCollectionView.allowsMultipleSelection = true
        diamondsCollectionView.allowsMultipleSelection = true
        spadesCollectionView.allowsMultipleSelection = true
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

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let cardSelectCell = cell as? CardSelectCollectionViewCell {
            let card: Card = selectCard(collectionView, indexPath.item)
            let imageName: String = cardToImageNameMapper.map(card)
            cardSelectCell.Image.image = UIImage(named: imageName)
            cardSelectCell.card = card
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 94, height: 120)
    }
    
    func selectCard(_ collectionView: UICollectionView, _ index: Int) -> Card {
        if collectionView == heartsCollectionView {
            return hearts[index]
        } else if collectionView == clubsCollectionView {
            return clubs[index]
        } else if collectionView == diamondsCollectionView {
            return diamonds[index]
        } else {
            return spades[index]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if totalNumberOfSelectedItems() == 2 {
            showMaximumSelection()
            return false
        } else {
            return true
        }
    }
    
    func totalNumberOfSelectedItems() -> Int {
        return heartsCollectionView.numberOfSelectedItems() +
            clubsCollectionView.numberOfSelectedItems() +
            spadesCollectionView.numberOfSelectedItems() +
            diamondsCollectionView.numberOfSelectedItems()
    }
    
    func showMaximumSelection() {
        let banner = NotificationBanner(title: "Maximum number of cards selected (2)" , subtitle: "Deselect a card before selecting another one", style: BannerStyle.info)
        banner.show(bannerPosition: BannerPosition.top)
    }
}