//
//  CardTests.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 22/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import XCTest
@testable import Tiny_Blackjack

class CardTest: XCTestCase {

    func test_Returns_11_For_Ace_Card_highValue() {
        let card: Card = Card(Suit.spade, Rank.ace, 1)
        XCTAssertEqual(card.highValue, 11)
    }

    func test_Returns_10_For_Face_Cards() {
        var cards: [Card] = [Card]()
        cards.append(Card(Suit.club, Rank.jack, 1))
        cards.append(Card(Suit.club, Rank.queen, 2))
        cards.append(Card(Suit.club, Rank.king, 3))

        for card in cards {
            XCTAssertEqual(card.lowValue, 10)
            XCTAssertEqual(card.highValue, 10)
        }
    }
}
