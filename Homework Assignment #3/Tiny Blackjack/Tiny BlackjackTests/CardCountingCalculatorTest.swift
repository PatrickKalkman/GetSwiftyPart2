//
//  CardCountingGameEngineTest.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 25/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import XCTest
@testable import Tiny_Blackjack

class CardCountingCalculatorTest: XCTestCase {

    func testRunningCountRound1() {
        let cardCountCalculator: CardCountCalculator = CardCountCalculator()
        cardCountCalculator.start(remainingDecks: 8)
        
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.two, 0))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.ace, 1))
        
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.jack, 2))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.ten, 3))

        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.seven, 4))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.three, 5))

        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.six, 6))
        
        XCTAssertEqual(cardCountCalculator.calculateRunningCount(), 0)
    }

    func testRunningCountRound2() {
        let cardCountCalculator: CardCountCalculator = CardCountCalculator()
        cardCountCalculator.start(remainingDecks: 8)

        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.three, 0))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.ace, 1))
        
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.king, 2))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.five, 3))
        
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.seven, 4))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.two, 5))
        
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.eight, 6))
        
        XCTAssertEqual(cardCountCalculator.calculateRunningCount(), 1)
    }
    
    func testRunningCountRound3() {
        let cardCountCalculator: CardCountCalculator = CardCountCalculator()
        cardCountCalculator.start(remainingDecks: 8)
        
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.three, 0))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.ace, 1))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.nine, 10))
        
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.king, 2))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.five, 3))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.six, 10))

        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.seven, 4))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.two, 5))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.ten, 10))

        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.eight, 6))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.jack, 6))
        cardCountCalculator.addCards(card: Card(Suit.spade, Rank.six, 6))

        XCTAssertEqual(cardCountCalculator.calculateRunningCount(), 1)
    }

    func testTrueCountRound1() {
        let cardCountCalculator: CardCountCalculator = CardCountCalculator()
        cardCountCalculator.start(remainingDecks: 5)

        // set running count to 10
        for _ in 1...10 {
            cardCountCalculator.addCards(card: Card(Suit.spade, Rank.two, 1))
        }
        
        XCTAssertEqual(cardCountCalculator.calculateTrueCount(), 2)
    }
    
    func testTrueCountRound2() {
        let cardCountCalculator: CardCountCalculator = CardCountCalculator()
        cardCountCalculator.start(remainingDecks: 2)
        
        // set running count to -7
        for _ in 1...7 {
            cardCountCalculator.addCards(card: Card(Suit.spade, Rank.king, 1))
        }
        
        XCTAssertEqual(cardCountCalculator.calculateTrueCount(), -3)
    }
    
    func testBettingUnitsRound1() {
        let cardCountCalculator: CardCountCalculator = CardCountCalculator()
        cardCountCalculator.start(remainingDecks: 2)
        
        // set running count to -7
        for _ in 1...7 {
            cardCountCalculator.addCards(card: Card(Suit.spade, Rank.king, 1))
        }
        
        XCTAssertEqual(cardCountCalculator.getBettingUnits(), 0)
    }
    
    func testBettingUnitsRound2() {
        let cardCountCalculator: CardCountCalculator = CardCountCalculator()
        cardCountCalculator.start(remainingDecks: 5)
        
        // set running count to 10
        for _ in 1...10 {
            cardCountCalculator.addCards(card: Card(Suit.spade, Rank.two, 1))
        }
        
        XCTAssertEqual(cardCountCalculator.getBettingUnits(), 1)
    }

}
