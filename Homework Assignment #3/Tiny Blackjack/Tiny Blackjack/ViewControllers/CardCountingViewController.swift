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
    
    var numberOfPlayers: UInt = 7
    var numberOfDecksRemaining: UInt = 8
    
    @IBOutlet var playerCardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle("PRACTICE CARD COUNTING")
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = UIColor.init(hex: "#337440FF")
        }
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
        
    }
    
    @IBAction func selectCards(_ sender: UIButton) {
        self.performSegue(withIdentifier: "selectCards", sender: self)
    }

    
}
