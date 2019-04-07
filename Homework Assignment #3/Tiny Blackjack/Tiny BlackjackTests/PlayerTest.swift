//
//  PlayerTest.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import XCTest
@testable import Tiny_Blackjack

class PlayerTest: XCTestCase {

    func test_player_contains_hand() {
        let player: Player = Player(name: "Testplayer", strategy: SimpleStrategy(), isDealer: false, isHuman: false)
        XCTAssert(player.numberOfCards(handIndex: 0) == 0)
    }
    
    func test_split_increases_the_number_of_hands() {
        let player: Player = Player(name: "Testplayer", strategy: SimpleStrategy(), isDealer: false, isHuman: false)

        player.add(handIndex: 0, card: Card(Suit.diamond, Rank.eight, 1))
        player.add(handIndex: 0, card: Card(Suit.club, Rank.eight, 2))
        
        XCTAssertEqual(player.numberOfHands(), 1)
        
        player.split(handIndex: 0)
        
        XCTAssertEqual(player.numberOfHands(), 2)
        XCTAssertEqual(player.getHand(handIndex: 0).getSuit(cardIndex: 0), Suit.club)
        XCTAssertEqual(player.getHand(handIndex: 1).getSuit(cardIndex: 0), Suit.diamond)
    }

}
