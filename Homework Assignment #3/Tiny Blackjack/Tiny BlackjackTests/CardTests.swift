//
//  CardTests.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 22/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import XCTest
@testable import Tiny_Blackjack

class CardTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {

    }

    func test_cardValueReturnsTheCorrectValue() {
        let card : Card = Card(suit: Suit.Spade, rank: Rank.Ace)
        XCTAssertEqual(card.value, 11)
    }
}
