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
    private var hands: [Hand] = [Hand]()
    let strategy: BlackjackStrategy
    var lastProposedAction: ProposedAction = ProposedAction.dontknow
    var isDealer: Bool
    
    var numberOfCards: Int {
        return hands[0].count
    }
    
    var hand: Hand {
        return hands[0]
    }

    init(name: String, hand: Hand, strategy: BlackjackStrategy, isDealer: Bool) {
        self.name = name
        self.hands.append(hand)
        self.strategy = strategy
        self.isDealer = isDealer
    }

    func askAction(dealerHand: Hand) -> ProposedAction {
        return strategy.calculateProposedAction(ownHand: hands[0], otherHand: dealerHand)
    }

    func add(card: Card) {
        self.hands[0].add(card)
    }

    func showState() -> String {
        if hands[0].isBusted() {
            return "\(name) Busted! hand: \(hands[0].getState())"
        } else {
            return "\(name) hand: \(hands[0].getState())"
        }
    }

    func isBusted() -> Bool {
        return hands[0].isBusted()
    }
    
    func split() {
        if hand.count == 2 {
            if hand.containsSameRank() {
                let card: Card = hand.remove(at: 1)
                let splittedHand: Hand = Hand()
                splittedHand.add(card)
                hands.append(splittedHand)
            }
        }
    }
}
