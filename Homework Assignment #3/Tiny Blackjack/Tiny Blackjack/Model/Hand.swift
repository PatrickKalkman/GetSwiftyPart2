//
//  Hand.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class Hand {
    private var cards: [Card] = [Card]()

    var count: Int {
        return cards.count
    }

    func add(_ card: Card) {
        cards.append(card)
    }

    func highValue() -> UInt8 {
        let faceUpCards: [Card] = cards.filter { $0.faceUp }
        return faceUpCards.reduce(0) { $0 + $1.highValue }
    }

    func lowValue() -> UInt8 {
        let faceUpCards: [Card] = cards.filter { $0.faceUp }
        return faceUpCards.reduce(0) { $0 + $1.lowValue }
    }
    
    func containsOnly(_ rank: Rank) -> Bool {
        return cards.allSatisfy { $0.rank == rank }
    }
    
    func containsSameRank() -> Bool {
        if let firstRank = cards.first?.rank {
            return cards.allSatisfy { $0.rank == firstRank }
        }
        return false
    }

    func isBusted() -> Bool {
        return getValue() > 21
    }

    func getValue() -> UInt8 {
        if isSoft() {
            if highValue() > lowValue() && highValue() < 22 {
               return highValue()
            }
            return lowValue()
        } else {
            return highValue()
        }
    }

    func isSoft() -> Bool {
        return lowValue() != highValue() && highValue() <= 21
    }

    func isHard() -> Bool {
        return !isSoft()
    }

    func getRank(cardIndex: Int) -> Rank {
        return cards[cardIndex].rank
    }

    func setCardsFaceUp() {
        for card in cards {
            card.turnFaceUp()
        }
    }

    func getState() -> String {
        var state: String = ""
        if cards.count == 0 {
            return "no cards"
        } else {
            for card in cards where card.faceUp {
                state += card.getState()
            }
        }
        return state
    }
    
    func remove(at: Int) -> Card {
        return cards.remove(at: at)
    }

}
