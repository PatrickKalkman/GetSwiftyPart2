//
//  CardCountingViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 14/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

class CardCountingViewController: BlackjackViewControllerBase {
    
    @IBOutlet weak var numberOfPlayersTitleLabel: UILabel!
    @IBOutlet weak var numberOfPlayersLabel: UILabel!
    @IBOutlet weak var numberOfPlayersStepper: UIStepper!
    
    @IBOutlet weak var numberOfDecksRemainingStepper: UIStepper!
    @IBOutlet weak var numberOfDecksRemainingTitleLabel: UILabel!
    @IBOutlet weak var numberOfDeckRemainingLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var selectCardsLabel: UILabel!
    
    var numberOfPlayers: UInt = 7
    var numberOfDecksRemaining: UInt = 8
    
    @IBOutlet var playerCardButtons: [UIButton]!
    
    var playerCards: [Int:[Card]] = [Int:[Card]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle("PRACTICE CARD COUNTING")
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = UIColor.init(hex: "#337440FF")
        }
        initializePlayers()
    }

    var previousNumberOfPlayers: UInt = 7
    
    @IBAction func numberOfPlayersChanged(_ sender: UIStepper) {
        numberOfPlayers = UInt(sender.value)
        numberOfPlayersLabel.text = String(numberOfPlayers)
        
        if numberOfPlayers < previousNumberOfPlayers {
            playerCardButtons![Int(numberOfPlayers)].animate(fadeIn: false)
        } else {
            playerCardButtons![Int(numberOfPlayers - 1)].animate(fadeIn: true)
        }
        
        previousNumberOfPlayers = numberOfPlayers
    }
    
    @IBAction func numberOfDecksChanged(_ sender: UIStepper) {
        numberOfDecksRemaining = UInt(sender.value)
        numberOfDeckRemainingLabel.text = String(numberOfDecksRemaining)
    }
    
    @IBAction func startPlaying(_ sender: UIButton) {
        numberOfPlayersTitleLabel.animate(fadeIn: false)
        numberOfPlayersLabel.animate(fadeIn: false)
        numberOfPlayersStepper.animate(fadeIn: false)
        
        numberOfDecksRemainingStepper.animate(fadeIn: false)
        numberOfDecksRemainingTitleLabel.animate(fadeIn: false)
        numberOfDeckRemainingLabel.animate(fadeIn: false)
        startButton.animate(fadeIn: false)
        selectCardsLabel.hideWithAnimation(hidden: false)
        
        setTitle("")
    }
    
    func initializePlayers() {
        for playerIndex in 0...6 {
            playerCards[playerIndex] = [Card]()
        }
    }
    
    @IBAction func selectCards(_ sender: UIButton) {
        self.performSegue(withIdentifier: "selectCards", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectCardsViewController = segue.destination as? SelectCardsViewController {
            selectCardsViewController.selectedCards.removeAll()
            if let playerButton = sender as? UIButton {
                selectCardsViewController.playerIndex = playerButton.tag
                selectCardsViewController.selectedCards.append(contentsOf: playerCards[playerButton.tag]!)
            }
        }
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if let source = segue.source as? SelectCardsViewController {
            if source.selectedCards.count > 0 {
                playerCards[source.playerIndex]!.removeAll()
                playerCards[source.playerIndex]!.append(contentsOf: source.selectedCards)
                print("player \(source.playerIndex), cards: \(playerCards[source.playerIndex]!.count)")
            }
        }
    }
}
