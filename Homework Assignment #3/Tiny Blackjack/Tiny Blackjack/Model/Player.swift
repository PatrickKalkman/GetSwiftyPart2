//
//  Player.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class Player {

    let hand: Hand
    let strategy: BlackjackStrategy

    var numberOfCards: Int {
        return hand.count
    }

    init(hand: Hand, strategy: BlackjackStrategy) {
        self.hand = hand
        self.strategy = strategy
    }
    
    func askAction(dealerHand: Hand) -> ProposedAction {
        return strategy.calculateProposedAction(playerHand: hand, dealerHand: dealerHand)
    }

    func add(card: Card) {
        self.hand.add(card)
    }

    func showState() {
        self.hand.showState()
    }
}
