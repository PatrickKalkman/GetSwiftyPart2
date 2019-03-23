//
//  DealerTest.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import XCTest
@testable import Tiny_Blackjack

class GameTest: XCTestCase {

    func test_hit_returns_card_from_deck() {
        let game: Game = Game(Deck())
        
        let cardFromDeck: Card = dealer.hit()
        XCTAssert(cardFromDeck.lowValue > 0)
    }
}
