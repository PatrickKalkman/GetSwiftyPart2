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
        return cards.reduce(0) { (total, card) in total + (card.faceUp ? card.highValue : 0) }
    }

    func lowValue() -> UInt8 {
        return cards.reduce(0) { (total, card) in total + (card.faceUp ? card.lowValue : 0) }
    }

    func isSoft() -> Bool {
        return lowValue() != highValue()
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

    func showState() {
        if cards.count == 0 {
            print("hand contains no cards")
        } else {
            print("hand:")
            for card in cards {
                if card.faceUp {
                    print("\(card.showState())")
                }
            }
            print("total value low:\(lowValue()) high:\(highValue())")
        }
    }

}
