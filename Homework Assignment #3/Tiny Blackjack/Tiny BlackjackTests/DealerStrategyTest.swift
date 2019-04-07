//
//  SimpleStrategy.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import XCTest
@testable import Tiny_Blackjack

class DealerStrategyTest: XCTestCase {
    
// If the card total is 16 points or lower, the dealer will always draw another card from the deck.
// The dealer will continue drawing cards from the deck until the house hand has at least 17 points, or until it goes
// bust by going over 21. If the dealer has 17 points off the deal without an Ace, most blackjack rules say the dealer
// will stand, even if a 21 player has a higher total.

// The dealer also might have a soft 17 hand, which is one that includes an Ace and any other cards whose combined
// value totals six points. Both land-based casinos and online blackjack casinos who support live dealer blackjack
// require dealers to take at least one more card with the dealer has a soft 17 showing. The dealer will continue
// taking more cards—until the house’s hand either becomes a hard 17 or higher, or the hand goes over 21 and goes bust.

    func test_hit_when_dealer_total_is_16_or_lower() {
        let card1: Card = Card(Suit.heart, Rank.eight, 1)
        let card2: Card = Card(Suit.club, Rank.four, 2)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let card3: Card = Card(Suit.club, Rank.five, 1)
        let dealerHand: Hand = Hand()
        dealerHand.add(card3)
        
        let strategy: DealerStrategy = DealerStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(ownHand: dealerHand, otherHand: playerHand)
        XCTAssertEqual(action, ProposedAction.hit)
    }
    
    func test_stand_when_dealer_total_is_17_or_higher() {
        let card1: Card = Card(Suit.heart, Rank.eight, 1)
        let card2: Card = Card(Suit.club, Rank.jack, 2)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let dealerHand: Hand = Hand()
        let card3: Card = Card(Suit.club, Rank.jack, 1)
        let card4: Card = Card(Suit.diamond, Rank.seven, 2)
        dealerHand.add(card3)
        dealerHand.add(card4)
        
        let strategy: DealerStrategy = DealerStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(ownHand: dealerHand, otherHand: playerHand)
        XCTAssertEqual(action, ProposedAction.stand)
    }
    
    func test_stand_when_dealer_total_is_17_soft() {
        let card1: Card = Card(Suit.heart, Rank.eight, 1)
        let card2: Card = Card(Suit.club, Rank.jack, 2)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let dealerHand: Hand = Hand()
        let card3: Card = Card(Suit.club, Rank.ace, 1)
        let card4: Card = Card(Suit.diamond, Rank.six, 2)
        dealerHand.add(card3)
        dealerHand.add(card4)
        
        let strategy: DealerStrategy = DealerStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(ownHand: dealerHand, otherHand: playerHand)
        XCTAssertEqual(action, ProposedAction.hit)
    }
    
    func test_stand_when_dealer_total_is_17_hard_from_soft() {
        let card1: Card = Card(Suit.heart, Rank.eight, 1)
        let card2: Card = Card(Suit.club, Rank.jack, 2)
        let playerHand: Hand = Hand()
        playerHand.add(card1)
        playerHand.add(card2)
        
        let dealerHand: Hand = Hand()
        let card3: Card = Card(Suit.club, Rank.ace, 1)
        let card4: Card = Card(Suit.diamond, Rank.six, 2)
        let card5: Card = Card(Suit.diamond, Rank.king, 3)
        dealerHand.add(card3)
        dealerHand.add(card4)
        dealerHand.add(card5)
        
        let strategy: DealerStrategy = DealerStrategy()
        let action: ProposedAction = strategy.calculateProposedAction(ownHand: dealerHand, otherHand: playerHand)
        XCTAssertEqual(action, ProposedAction.stand)
    }
}
