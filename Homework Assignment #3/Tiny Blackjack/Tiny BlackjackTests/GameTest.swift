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
        let game: Game = Game(Deck())
        XCTAssertEqual(0, game.numberOfPlayers)
    }
    
    func test_newGame_can_start() {
        let game: Game = Game(Deck())
        try? game.start(numberOfPlayers: 1)
        XCTAssertEqual(1, game.numberOfPlayers)
    }
    
    func test_whenStarted_cant_startAgain() {
        let game: Game = Game(Deck())
        try? game.start(numberOfPlayers: 1)
        
        XCTAssertThrowsError(try game.start(numberOfPlayers: 1)) { error in
            XCTAssertEqual(error as! GameError, GameError.cannotStartStartedGame)
        }
    }

    func test_start_deals_every_player_two_cards() {
        let game: Game = Game(Deck())
        game.showState()
        try? game.start(numberOfPlayers: 2)
        game.showState()
    }
}