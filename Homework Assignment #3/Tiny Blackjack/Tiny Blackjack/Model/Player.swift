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
    
    func numberOfCards(handIndex: Int) -> Int {
        return hands[handIndex].count
    }
    
    func numberOfHands() -> Int {
        return hands.count
    }
    
    func getHand(handIndex: Int) -> Hand {
        return hands[handIndex]
    }

    init(name: String, hand: Hand, strategy: BlackjackStrategy, isDealer: Bool) {
        self.name = name
        self.hands.append(hand)
        self.strategy = strategy
        self.isDealer = isDealer
    }

    func askAction(handIndex: Int, dealerHand: Hand) -> ProposedAction {
        return strategy.calculateProposedAction(ownHand: hands[handIndex], otherHand: dealerHand)
    }

    func add(handIndex: Int, card: Card) {
        self.hands[handIndex].add(card)
    }

    func getState() -> String {
        var stateString: String = ""
        for hand in hands {
            if hand.isBusted() {
                stateString += "\(name) Busted! hand: \(hand.getState())"
            } else {
                stateString += "\(name) hand: \(hand.getState())"
            }
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
            let card: Card = handToSplit.remove(at: 1)
            let splittedHand: Hand = Hand()
            splittedHand.add(card)
            hands.append(splittedHand)
        }
    }
}
