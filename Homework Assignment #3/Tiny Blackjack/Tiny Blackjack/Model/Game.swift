//
//  Dealer.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class Game {
    
    let deck: Deck
    
    init(_ deck: Deck) {
        self.deck = deck
    }
    
    func hit() -> Card {
        if !deck.isEmpty {
            return deck.draw()
        }
        fatalError("Deck is empty")
    }
    
    func stay() {
        // Player decided to stay
    }
}
