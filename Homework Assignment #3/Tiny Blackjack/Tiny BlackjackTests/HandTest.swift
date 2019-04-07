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
        hand.add(Card(Suit.heart, Rank.queen, 1))
        XCTAssertEqual(hand.lowValue(), 10)
    }

    func test_lowValueAndHighValue_singleFaceCard_returns_ten() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.heart, Rank.queen, 1))
        XCTAssertEqual(hand.lowValue(), 10)
        XCTAssertEqual(hand.highValue(), 10)
    }

    func test_handWithThreeCards_returns_correct_total() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.heart, Rank.queen, 1))
        hand.add(Card(Suit.heart, Rank.two, 2))
        hand.add(Card(Suit.heart, Rank.four, 3))

        XCTAssertEqual(hand.lowValue(), 16)
        XCTAssertEqual(hand.highValue(), 16)
    }

    func test_handWithFourCardsIncludingAce_returns_correct_total() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.heart, Rank.queen, 1))
        hand.add(Card(Suit.heart, Rank.two, 2))
        hand.add(Card(Suit.heart, Rank.four, 3))
        hand.add(Card(Suit.heart, Rank.ace, 4))

        XCTAssertEqual(hand.lowValue(), 17)
        XCTAssertEqual(hand.highValue(), 27)
    }
    
    func test_handWithTwoCardsIncludingAce_isSoft() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.club, Rank.ace, 1))
        hand.add(Card(Suit.diamond, Rank.six, 2))
        
        XCTAssertTrue(hand.isSoft())
    }
    
    func test_containsOnly_handWithTwoEqualCards_returns_true() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.club, Rank.ace, 1))
        hand.add(Card(Suit.diamond, Rank.ace, 2))
        
        XCTAssertTrue(hand.containsOnly(Rank.ace))
    }
    
    func test_isBlackjack_AceAndTen_returns_true() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.club, Rank.ace, 1))
        hand.add(Card(Suit.diamond, Rank.jack, 2))
        
        XCTAssertTrue(hand.isBlackjack())
    }
    
    func test_isBlackjack_AceAndSeven_returns_false() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.club, Rank.ace, 1))
        hand.add(Card(Suit.diamond, Rank.seven, 2))
        
        XCTAssertFalse(hand.isBlackjack())
    }
    
    func test_isBlackjack_Seven_returns_false() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.diamond, Rank.seven, 1))
        
        XCTAssertFalse(hand.isBlackjack())
    }
    
    func test_hasAce_value_should_return_lowValue() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.heart, Rank.five, 1))
        hand.add(Card(Suit.heart, Rank.ace, 2))
        hand.add(Card(Suit.diamond, Rank.three,3 ))
        hand.add(Card(Suit.spade, Rank.six, 4))

        XCTAssertEqual(hand.getValue(), 15)
    }
    
    func test_hasAce_value_should_return_highValue() {
        let hand: Hand = Hand()
        hand.add(Card(Suit.heart, Rank.six, 5))
        hand.add(Card(Suit.heart, Rank.ace, 6))
        
        XCTAssertEqual(hand.getValue(), 17)
    }
}
