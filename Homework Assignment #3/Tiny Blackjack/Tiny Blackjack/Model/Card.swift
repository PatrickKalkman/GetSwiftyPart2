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
    
    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
    
    var value: UInt8 {
        return Card.values[self.rank]!
    }
    
    static var values : [Rank : UInt8] = [
        Rank.Ace : 11,
        Rank.Two : 2,
        Rank.Three : 3,
        Rank.Four: 4,
        Rank.Five: 5,
        Rank.Six: 6,
        Rank.Seven: 7,
        Rank.Eight: 8,
        Rank.Nine: 9,
        Rank.Ten: 10,
        Rank.Jack: 10,
        Rank.Queen: 10,
        Rank.King: 10
    ]
}
