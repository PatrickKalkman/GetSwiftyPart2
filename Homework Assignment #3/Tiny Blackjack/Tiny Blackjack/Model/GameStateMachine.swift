//
//  GameStateMachine.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 29/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftState

class GameStateMachine {
    
    let gameEngine: BlackjackProtocol

    let blackjackStateMachine = StateMachine<GameStates, GameEvents>(state: .waitingForStart) {
        // Define blackjack game state machine
        $0.addRoutes(event: .start, transitions: [GameStates.waitingForStart => GameStates.started])
        $0.addRoutes(event: .shuffle, transitions: [GameStates.started => GameStates.shuffleDeck])
        $0.addRoutes(event: .shuffled, transitions: [GameStates.shuffleDeck => GameStates.checkingDeck])
        $0.addRoutes(event: .checked, transitions: [GameStates.checkingDeck => GameStates.placeBets])
        $0.addRoutes(event: .betsPlaced, transitions: [GameStates.placeBets => GameStates.dealCards])
        $0.addRoutes(event: .dealt, transitions: [GameStates.dealCards => GameStates.dealerBlackjackTest])
        $0.addRoutes(event: .dealerNoBlackjack, transitions: [GameStates.dealerBlackjackTest => GameStates.playersPlay_selectPlayer])
        $0.addRoutes(event: .dealerHasBlackjack, transitions: [GameStates.dealerBlackjackTest => GameStates.calculateResult])
        $0.addRoutes(event: .playerSelected, transitions: [GameStates.playersPlay_selectPlayer => GameStates.playersPlay_selectHand])
        $0.addRoutes(event: .allPlayersFinished, transitions: [GameStates.playersPlay_selectPlayer => GameStates.dealerPlay_getChoice])
        $0.addRoutes(event: .playerHandSelected, transitions: [GameStates.playersPlay_selectHand => GameStates.playersPlay_getChoice])
        $0.addRoutes(event: .playerHandsFinished, transitions: [GameStates.playersPlay_selectHand => GameStates.playersPlay_selectPlayer])
        $0.addRoutes(event: .hitPlayer, transitions: [GameStates.playersPlay_getChoice => GameStates.playersPlay_hit])
        $0.addRoutes(event: .playerChoose, transitions: [GameStates.playersPlay_hit => GameStates.playersPlay_getChoice])
        $0.addRoutes(event: .standPlayer, transitions: [GameStates.playersPlay_getChoice => GameStates.playersPlay_selectHand])
        $0.addRoutes(event: .bustPlayer, transitions: [GameStates.playersPlay_getChoice => GameStates.playersPlay_selectHand])
        $0.addRoutes(event: .splitPlayerHand, transitions: [GameStates.playersPlay_getChoice => GameStates.playersPlay_splitHand])
        $0.addRoutes(event: .playerHandSplitted, transitions: [GameStates.playersPlay_splitHand => GameStates.playersPlay_selectHand])
        $0.addRoutes(event: .hitDealer, transitions: [GameStates.dealerPlay_getChoice => GameStates.dealerPlay_hit])
        $0.addRoutes(event: .standDealer, transitions: [GameStates.dealerPlay_getChoice => GameStates.calculateResult])
        $0.addRoutes(event: .dealerChoose, transitions: [GameStates.dealerPlay_hit => GameStates.dealerPlay_getChoice])
        $0.addRoutes(event: .bustDealer, transitions: [GameStates.dealerPlay_getChoice => GameStates.calculateResult])
        $0.addRoutes(event: .resultsCalculated, transitions: [GameStates.dealerPlay_getChoice => GameStates.distributeBets])
        $0.addRoutes(event: .nextRound, transitions: [GameStates.distributeBets => GameStates.checkingDeck])
    }
    
    init(gameEngine: BlackjackProtocol) {
        self.gameEngine = gameEngine
        
        // Add function calls when state is entered
        blackjackStateMachine.addRoute(.any => .started) { context in self.start(context) }
        blackjackStateMachine.addRoute(.any => .shuffleDeck) { context in self.shuffle(context) }
        blackjackStateMachine.addRoute(.any => .checkingDeck) { context in self.checkDeck(context) }
        blackjackStateMachine.addRoute(.any => .placeBets) { context in self.placeBets(context) }
        blackjackStateMachine.addRoute(.any => .dealCards) { context in self.dealCards(context) }
        blackjackStateMachine.addRoute(.any => .dealerBlackjackTest) { context in self.dealerBlackjackTest(context) }
        blackjackStateMachine.addRoute(.any => .playersPlay_selectPlayer) { context in self.selectPlayer(context) }
        blackjackStateMachine.addRoute(.any => .calculateResult) { context in self.calculateResult(context) }
        blackjackStateMachine.addRoute(.any => .playersPlay_selectHand) { context in self.selectHand(context) }
        blackjackStateMachine.addRoute(.any => .playersPlay_getChoice) { context in self.playerGetChoice(context) }
        blackjackStateMachine.addRoute(.any => .dealerPlay_getChoice) { context in self.dealerGetChoice(context) }
        blackjackStateMachine.addRoute(.any => .playersPlay_hit) { context in self.hitPlayer(context) }
        blackjackStateMachine.addRoute(.any => .playersPlay_splitHand) { context in self.splitHand(context) }
        blackjackStateMachine.addRoute(.any => .dealerPlay_hit) { context in self.hitDealer(context) }
        blackjackStateMachine.addRoute(.any => .distributeBets) { context in self.distributeBets(context) }
    }
    
    func triggerEvent(_ event: GameEvents) {
        self.blackjackStateMachine <-! event
    }
    
    func start(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.start(context)
    }
    
    func shuffle(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.shuffle(context)
    }
    
    func checkDeck(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.checkDeck(context)
    }
    
    func placeBets(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.placeBets(context)
    }
    
    func dealCards(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.dealCards(context)
    }
    
    func dealerBlackjackTest(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.dealerBlackjackTest(context)
    }
    
    func selectPlayer(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.selectPlayer(context)
    }
    
    func calculateResult(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.calculateResult(context)
    }
    
    func selectHand(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.selectHand(context)
    }
    
    func playerGetChoice(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.playerGetChoice(context)
    }
    
    func dealerGetChoice(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.dealerGetChoice(context)
    }
    
    func hitPlayer(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.hitPlayer(context)
    }
    
    func splitHand(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.splitHand(context)
    }
    
    func hitDealer(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.hitDealer(context)
    }

    func distributeBets(_ context: StateMachine<GameStates, GameEvents>.Context) {
        self.gameEngine.distributeBets(context)
    }
}
