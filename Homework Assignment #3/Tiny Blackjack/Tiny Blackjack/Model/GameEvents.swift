//
//  GameEvents.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 29/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftState

enum GameEvents: EventType {
    case start
    case playersAdded
    case checked
    case shuffle
    case shuffled
    case betsPlaced
    case dealt
    case dealerBlackjackTest
    case dealerNoBlackjack
    case dealerHasBlackjack
    case allPlayersFinished
    case playerSelected
    case playerHandSelected
    case playerHandsFinished
    case playerNoBlackjack
    case playerChoose
    case hitPlayer
    case standPlayer
    case bustPlayer
    case splitPlayerHand
    case playerHandSplitted
    case surrenderPlayer
    case dealerPlays
    case hitDealer
    case standDealer
    case bustDealer
    case dealerChoose
    case resultsCalculated
    case nextRound
}
