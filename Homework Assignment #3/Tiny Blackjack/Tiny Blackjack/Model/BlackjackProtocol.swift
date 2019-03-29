//
//  BlackjackProtocol.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 29/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftState

protocol BlackjackProtocol {
    func start(_ context: StateMachine<GameStates, GameEvents>.Context)
    func shuffle(_ context: StateMachine<GameStates, GameEvents>.Context)
    func checkDeck(_ context: StateMachine<GameStates, GameEvents>.Context)
    func placeBets(_ context: StateMachine<GameStates, GameEvents>.Context)
    func dealCards(_ context: StateMachine<GameStates, GameEvents>.Context)
    func dealerBlackjackTest(_ context: StateMachine<GameStates, GameEvents>.Context)
    func selectPlayer(_ context: StateMachine<GameStates, GameEvents>.Context)
    func calculateResult(_ context: StateMachine<GameStates, GameEvents>.Context)
    func selectHand(_ context: StateMachine<GameStates, GameEvents>.Context)
    func playerGetChoice(_ context: StateMachine<GameStates, GameEvents>.Context)
    func dealerGetChoice(_ context: StateMachine<GameStates, GameEvents>.Context)
    func hitPlayer(_ context: StateMachine<GameStates, GameEvents>.Context)
    func splitHand(_ context: StateMachine<GameStates, GameEvents>.Context)
    func hitDealer(_ context: StateMachine<GameStates, GameEvents>.Context)
    func distributeBets(_ context: StateMachine<GameStates, GameEvents>.Context)
}
