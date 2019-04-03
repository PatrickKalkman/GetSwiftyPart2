//
//  HandResult.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 03/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

struct HandResult {
    var playerIndex: Int
    var handIndex: Int
    var result: GameResult
}

enum GameResult {
    case PlayerWins
    case DealerWins
    case Push
}
