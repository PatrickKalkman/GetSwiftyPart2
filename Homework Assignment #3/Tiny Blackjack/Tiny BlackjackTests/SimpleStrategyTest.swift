//
//  SimpleStrategy.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import XCTest
@testable import Tiny_Blackjack

class SimpleStrategyTest: XCTestCase {
    
    
//    Bank 2 t/m 6: je past bij 12 punten of hoger
//    Bank 7 t/m A: je past bij 17 punten of hoger

    func test_stand_when_dealer_2_to_6_hand_is_12_or_higher() {
        let card1: Card = Card(Suit.heart, Rank.eight)
        let card2: Card = Card(Suit.club, Rank.four)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let card3: Card = Card(Suit.club, Rank.five)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3)
        
        let strategy: SimpleStrategy = SimpleStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(playerHand: playerHand, dealerHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.stand)
    }

    func test_stand_when_dealer_7_to_11_hand_is_17_or_higher() {
        let card1: Card = Card(Suit.heart, Rank.eight)
        let card2: Card = Card(Suit.club, Rank.nine)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let card3: Card = Card(Suit.club, Rank.ten)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3)
        
        let strategy: SimpleStrategy = SimpleStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(playerHand: playerHand, dealerHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.stand)
    }
    
    func test_stand_when_dealer_2_to_6_hand_is_18_or_higher_including_ace() {
        let card1: Card = Card(Suit.heart, Rank.ace)
        let card2: Card = Card(Suit.club, Rank.seven)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let card3: Card = Card(Suit.club, Rank.five)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3)
        
        let strategy: SimpleStrategy = SimpleStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(playerHand: playerHand, dealerHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.stand)
    }
    
    func test_stand_when_dealer_7_to_11_hand_is_19_or_higher_including_ace() {
        let card1: Card = Card(Suit.heart, Rank.ace)
        let card2: Card = Card(Suit.club, Rank.eight)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let card3: Card = Card(Suit.club, Rank.eight)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3)
        
        let strategy: SimpleStrategy = SimpleStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(playerHand: playerHand, dealerHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.stand)
    }
    
//    Wanneer splits je?
//    4-4, 5-5, 10-10: nooit splitsen
//    8-8, Aas-Aas: altijd splitsen
//    2-2, 3-3, 6-6, 7-7, 9-9: alleen splitsen als de bank 2 t/m 6 heeft

    func test_split_when_8_8() {
        let card1: Card = Card(Suit.heart, Rank.eight)
        let card2: Card = Card(Suit.club, Rank.eight)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let card3: Card = Card(Suit.club, Rank.eight)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3)
        
        let strategy: SimpleStrategy = SimpleStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(playerHand: playerHand, dealerHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.split)
    }
    
    func test_split_when_ace_ace() {
        let card1: Card = Card(Suit.heart, Rank.ace)
        let card2: Card = Card(Suit.club, Rank.ace)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let card3: Card = Card(Suit.club, Rank.eight)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3)
        
        let strategy: SimpleStrategy = SimpleStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(playerHand: playerHand, dealerHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.split)
    }
    

//    2-2, 3-3, 6-6, 7-7, 9-9: alleen splitsen als de bank 2 t/m 6 heeft
    func test_split_when_two_two_dealer_lower_than_7() {
        let card1: Card = Card(Suit.heart, Rank.two)
        let card2: Card = Card(Suit.club, Rank.two)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let card3: Card = Card(Suit.club, Rank.two)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3)
        
        let strategy: SimpleStrategy = SimpleStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(playerHand: playerHand, dealerHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.split)
    }
    
    func test_split_when_nine_nine_dealer_lower_than_7() {
        let card1: Card = Card(Suit.heart, Rank.nine)
        let card2: Card = Card(Suit.club, Rank.nine)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let card3: Card = Card(Suit.club, Rank.two)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3)
        
        let strategy: SimpleStrategy = SimpleStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(playerHand: playerHand, dealerHand: dealerHand)
        XCTAssertEqual(action, ProposedAction.split)
    }
    
    func test_no_split_when_nine_nine_dealer_has_7() {
        let card1: Card = Card(Suit.heart, Rank.nine)
        let card2: Card = Card(Suit.club, Rank.nine)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let card3: Card = Card(Suit.club, Rank.two)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3)
        
        let strategy: SimpleStrategy = SimpleStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(playerHand: playerHand, dealerHand: dealerHand)
        XCTAssertFalse(action == ProposedAction.split)
    }
    
}