//
//  CardTests.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 22/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import XCTest
@testable import Tiny_Blackjack

class DeckTests: XCTestCase {

    func test_count_returns_52_cards_in_deck() {
        let deck: Deck = Deck()
        XCTAssertEqual(deck.count, 52)
    }

    func test_draw_removes_card_from_deck() {
        let deck: Deck = Deck()
        let card: Card = deck.draw()
        XCTAssertEqual(deck.count, 51)
        XCTAssert(card.lowValue > 0)
    }

    func test_isEmpty_returns_false_with_new_deck() {
        let deck: Deck = Deck()
        XCTAssertFalse(deck.isEmpty)
    }

    func test_isEmpty_when_all_cards_are_drawn_true() {
        let deck: Deck = Deck()

        // draw all cards
        for _ in 1...52 {
            _ = deck.draw()
        }

        XCTAssertTrue(deck.isEmpty)
    }
}
