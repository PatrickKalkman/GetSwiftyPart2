//
//  GameState.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftState

enum GameStates: StateType {
    case waitingForStart
    case started
    case shuffleDeck
    case checkingDeck
    case placeBets
    case dealCards
    case dealerBlackjackTest
    case playersPlaySelectPlayer
    case playersPlaySelectHand
    case playersPlayBlackjack
    case playersPlayGetChoice
    case playersPlayDoubleDown
    case playersPlayHit
    case playersPlaySplitHand
    case playersPlaySurrender
    case dealerPlayGetChoice
    case dealerPlayHit
    case calculateResult
    case distributeBets
}
