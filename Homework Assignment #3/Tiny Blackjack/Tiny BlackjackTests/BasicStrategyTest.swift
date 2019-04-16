//
//  BasicStrategyTest.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 16/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import XCTest
@testable import Tiny_Blackjack

class BasicStrategyTest: XCTestCase {
    
    func test_stand_when_dealer_6_hand_is_hard_12() {
        let card1: Card = Card(Suit.heart, Rank.eight, 1)
        let card2: Card = Card(Suit.club, Rank.four, 2)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2) // 12
        
        let card3: Card = Card(Suit.club, Rank.six, 1)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3) // 6
        
        let strategy: BlackjackStrategyProtocol = BasicStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(ownHand: playerHand, otherHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.stand)
    }
    
    func test_hit_when_dealer_10_hand_is_hard_12() {
        let card1: Card = Card(Suit.heart, Rank.eight, 1)
        let card2: Card = Card(Suit.club, Rank.four, 2)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2) // 12
        
        let card3: Card = Card(Suit.club, Rank.jack, 1)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3) // 10
        
        let strategy: BlackjackStrategyProtocol = BasicStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(ownHand: playerHand, otherHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.hit)
    }
    
    func test_hit_when_dealer_8_hand_is_soft_17() {
        let card1: Card = Card(Suit.heart, Rank.ace, 1)
        let card2: Card = Card(Suit.club, Rank.six, 2)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2) // Soft 17
        
        let card3: Card = Card(Suit.club, Rank.eight, 1)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3) // 8
        
        let strategy: BlackjackStrategyProtocol = BasicStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(ownHand: playerHand, otherHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.hit)
    }
    
    func test_doubleOrStand_when_dealer_6_hand_is_soft_18() {
        let card1: Card = Card(Suit.heart, Rank.ace, 1)
        let card2: Card = Card(Suit.club, Rank.seven, 2)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2) // Soft 18
        
        let card3: Card = Card(Suit.club, Rank.six, 1)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3) // 6
        
        let strategy: BlackjackStrategyProtocol = BasicStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(ownHand: playerHand, otherHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.doubleOrStand)
    }
}
