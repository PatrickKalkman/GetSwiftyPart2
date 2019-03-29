//
//  DealerTest.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import XCTest
@testable import Tiny_Blackjack

class GameTest: XCTestCase {

    func test_numberOfPlayers_returns_the_number_of_players() {
        let game: Game = Game()
        XCTAssertEqual(1, game.numberOfPlayers)
    }

    func test_start_deals_every_player_two_cards() {
        let game: Game = Game()
        game.triggerEvent(GameEvents.start)
        print(game.getState())
    }
}
