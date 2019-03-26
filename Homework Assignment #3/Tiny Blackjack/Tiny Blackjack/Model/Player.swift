//
//  Player.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class Player {

    let name: String
    let hand: Hand
    let strategy: BlackjackStrategy
    var state: PlayerState = PlayerState.none
    var lastProposedAction: ProposedAction = ProposedAction.dontknow

    var numberOfCards: Int {
        return hand.count
    }

    init(name: String, hand: Hand, strategy: BlackjackStrategy) {
        self.name = name
        self.hand = hand
        self.strategy = strategy
    }
    
    func askAction(dealerHand: Hand) -> ProposedAction {
        lastProposedAction = strategy.calculateProposedAction(ownHand: hand, otherHand: dealerHand)
        print("\(name) proposed action -> \(lastProposedAction)")
        return lastProposedAction
    }

    func add(card: Card) {
        self.hand.add(card)
    }

    func showState() {
        self.hand.showState()
    }
    
    func isBusted() -> Bool {
        if hand.isHard() && hand.highValue() > 21 {
            return true
        } else if hand.isSoft() && hand.lowValue() > 21 {
            return true
        }
        return false
    }
    
    func setState(_ state: PlayerState) {
        self.state = state
    }
}
