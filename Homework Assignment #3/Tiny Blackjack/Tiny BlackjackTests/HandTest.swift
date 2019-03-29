//
//  HandTest.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import XCTest
@testable import Tiny_Blackjack

class HandTest: XCTestCase {

    func test_new_hand_contains_no_cards() {
        let hand: Hand = Hand()
        XCTAssertEqual(hand.count, 0)
    }

    func test_highValue_empty_hand_return_zero() {
        let hand: Hand = Hand()
        XCTAssertEqual(hand.highValue(), 0)
    }

    func test_lowValue_empty_hand_return_zero() {
        let hand: Hand = Hand()
        XCTAssertEqual(hand.lowValue(), 0)
    }

    func test_lowValue_singleFaceCard_returns_ten() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.heart, Rank.queen))
        XCTAssertEqual(hand.lowValue(), 10)
    }

    func test_lowValueAndHighValue_singleFaceCard_returns_ten() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.heart, Rank.queen))
        XCTAssertEqual(hand.lowValue(), 10)
        XCTAssertEqual(hand.highValue(), 10)
    }

    func test_handWithThreeCards_returns_correct_total() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.heart, Rank.queen))
        hand.add(Card(Suit.heart, Rank.two))
        hand.add(Card(Suit.heart, Rank.four))

        XCTAssertEqual(hand.lowValue(), 16)
        XCTAssertEqual(hand.highValue(), 16)
    }

    func test_handWithFourCardsIncludingAce_returns_correct_total() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.heart, Rank.queen))
        hand.add(Card(Suit.heart, Rank.two))
        hand.add(Card(Suit.heart, Rank.four))
        hand.add(Card(Suit.heart, Rank.ace))

        XCTAssertEqual(hand.lowValue(), 17)
        XCTAssertEqual(hand.highValue(), 27)
    }
    
    func test_handWithTwoCardsIncludingAce_isSoft() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.club, Rank.ace))
        hand.add(Card(Suit.diamond, Rank.six))
        
        XCTAssertTrue(hand.isSoft())
    }
    
    func test_containsOnly_handWithTwoEqualCards_returns_true() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.club, Rank.ace))
        hand.add(Card(Suit.diamond, Rank.ace))
        
        XCTAssertTrue(hand.containsOnly(Rank.ace))
    }

}
