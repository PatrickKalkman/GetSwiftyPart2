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
        let player: Player = Player(name: "Testplayer", hand: Hand(), strategy: SimpleStrategy(), isDealer: false)
        XCTAssert(player.numberOfCards == 0)
    }

}
