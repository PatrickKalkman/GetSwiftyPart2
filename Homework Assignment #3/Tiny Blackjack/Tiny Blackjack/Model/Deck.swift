//
//  Deck.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 22/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class Deck {

    private var cards: [Card] = [Card]()

    var count: Int {
        return cards.count
    }

    var isEmpty: Bool {
        return cards.count == 0
    }

    init() {
        generateDeck()
        shuffle()
    }

    private func generateDeck() {
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                cards.append(Card(suit, rank))
            }
        }
    }

    private func shuffle() {
        self.cards.shuffle()
    }

    func draw() -> Card {
        return cards.removeFirst()
    }

}
