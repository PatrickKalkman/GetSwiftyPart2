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

    func test_start_deals_every_player_two_cards() {
        for _ in 1...30 {
            let game: GameEngine = GameEngine(gameResultCalculator: GameResultCalculator())
            game.start(numberOfPlayers: 5)
            print(game.getState())
        }
    }
}
