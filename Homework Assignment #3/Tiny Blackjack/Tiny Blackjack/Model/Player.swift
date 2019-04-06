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
    var isHuman: Bool
    var currentHandIndex: Int = 0
    
    func numberOfCards(handIndex: Int) -> Int {
        return hands[handIndex].count
    }

    func numberOfHands() -> Int {
        return hands.count
    }

    func getHand(handIndex: Int) -> Hand {
        return hands[handIndex]
    }

    init(name: String, strategy: BlackjackStrategy, isDealer: Bool, isHuman: Bool) {
        self.name = name
        self.hands.append(Hand())
        self.strategy = strategy
        self.isDealer = isDealer
        self.isHuman = isHuman
    }
    
    func clear() {
        self.hands.removeAll()
        self.hands.append(Hand())
    }

    func askAction(handIndex: Int, dealerHand: Hand) -> ProposedAction {
        return strategy.calculateProposedAction(ownHand: hands[handIndex], otherHand: dealerHand)
    }

    func askAction(ownHand: Hand, dealerHand: Hand) -> ProposedAction {
        return strategy.calculateProposedAction(ownHand: ownHand, otherHand: dealerHand)
    }

    func add(handIndex: Int, card: Card) {
        self.hands[handIndex].add(card)
    }

    func getState() -> String {
        var stateString: String = ""
        var handIndex: Int = 0
        for hand in hands {
            if hand.isBusted() {
                stateString += " hand \(handIndex): (Busted!) \(hand.getState())"
            } else {
                stateString += " hand \(handIndex): \(hand.getState())"
            }
            handIndex += 1
        }
        return stateString
    }

    func isBusted(handIndex: Int) -> Bool {
        return hands[handIndex].isBusted()
    }

    func split(handIndex: Int) {
        if handIndex > hands.count - 1 {
            print("Cannot split")
        }

        let handToSplit: Hand = hands[handIndex]
        if handToSplit.count == 2 && hands[handIndex].containsSameRank() {
            let card: Card = handToSplit.remove(cardIndex: 0)
            let splittedHand: Hand = Hand()
            splittedHand.add(card)
            hands.insert(splittedHand, at: handIndex + 1)
        }
    }

    func placeBets() {
        // Place the bets
    }
}
