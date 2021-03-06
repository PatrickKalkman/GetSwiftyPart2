//
//  Card.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 22/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class Card {
    let suit: Suit
    let rank: Rank
    let index: Int
    var faceUp: Bool = true

    init(_ suit: Suit, _ rank: Rank, _ index: Int) {
        self.suit = suit
        self.rank = rank
        self.index = index
    }

    var lowValue: UInt8 {
        return Card.values[self.rank]!.lowValue
    }

    var highValue: UInt8 {
        return Card.values[self.rank]!.highValue
    }

    func turnFaceDown() {
        faceUp = false
    }

    func turnFaceUp() {
        faceUp = true
    }

    static var values: [Rank: (lowValue: UInt8, highValue: UInt8)] = [
        Rank.ace: (1, 11),
        Rank.two: (2, 2),
        Rank.three: (3, 3),
        Rank.four: (4, 4),
        Rank.five: (5, 5),
        Rank.six: (6, 6),
        Rank.seven: (7, 7),
        Rank.eight: (8, 8),
        Rank.nine: (9, 9),
        Rank.ten: (10, 10),
        Rank.jack: (10, 10),
        Rank.queen: (10, 10),
        Rank.king: (10, 10)
    ]

    func getState() -> String {
        return "(\(self.rank) \(self.suit))"
    }

}
