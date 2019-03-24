//
//  GameState.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

enum GameStates {
    case waitingUntilStart
    case started
    case playingPlayer
    case playingDealer
    case finished
}

class GameState {
    private var state: GameStates = GameStates.waitingUntilStart
    private var whichPlayerPlaying: UInt8 = 0

    func setState(stateToSet: GameStates) {
        self.state = stateToSet
    }

    func getState() -> GameStates {
        return self.state
    }
}
