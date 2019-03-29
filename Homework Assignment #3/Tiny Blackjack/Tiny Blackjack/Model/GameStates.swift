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
    case playersPlay_selectPlayer
    case playersPlay_selectHand
    case playersPlay_blackjack
    case playersPlay_getChoice
    case playersPlay_hit
    case playersPlay_splitHand
    case playersPlay_surrender
    case dealerPlay_getChoice
    case dealerPlay_hit
    case calculateResult
    case distributeBets
}
