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
    case playersBetSelectPlayer
    case allBetsPlaced
    case dealCards
    case dealerBlackjackTest
    case showDealerBlackjack
    case playersPlaySelectPlayer
    case playersPlaySelectHand
    case playersPlayBlackjack
    case playersPlayGetChoice
    case playersPlayDoubleDown
    case playersPlayHit
    case playersPlaySplitHand
    case showSplittedHand
    case playersPlaySurrender
    case dealerStart
    case dealerPlayGetChoice
    case dealerPlayHit
    case calculateResult
    case distributeBets
    case finished
}
