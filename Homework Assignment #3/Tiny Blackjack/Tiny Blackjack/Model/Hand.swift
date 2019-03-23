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
        return cards.reduce(0) { (total, card) in total + card.highValue }
    }

    func lowValue() -> UInt8 {
        return cards.reduce(0) { (total, card) in total + card.lowValue }
    }
}
