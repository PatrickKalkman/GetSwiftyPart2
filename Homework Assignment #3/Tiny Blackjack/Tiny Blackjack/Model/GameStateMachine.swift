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

    let machine = StateMachine<GameStates, GameEvents>(state: .waitingForStart)
    
    init(gameEngine: BlackjackProtocol) {
        self.gameEngine = gameEngine
        
        machine.addRoutes(event: .start,
                          transitions: [GameStates.waitingForStart => GameStates.started]) { _ in self.start() }
        machine.addRoutes(event: .shuffle,
                          transitions: [GameStates.started => GameStates.shuffleDeck]) { _ in self.shuffle() }
        machine.addRoutes(event: .shuffled,
                          transitions: [GameStates.shuffleDeck => GameStates.checkingDeck]) { _ in self.checkDeck() }
        machine.addRoutes(event: .checked,
                          transitions: [GameStates.checkingDeck => GameStates.placeBets]) { _ in self.placeBets() }
        machine.addRoutes(event: .betsPlaced,
                          transitions: [GameStates.placeBets => GameStates.dealCards]) { _ in self.dealCards() }
        machine.addRoutes(event: .dealt,
                          transitions: [GameStates.dealCards => GameStates.dealerBlackjackTest]) { _ in self.dealerBlackjackTest() }
        machine.addRoutes(event: .dealerHasNoBlackjack,
                          transitions: [GameStates.dealerBlackjackTest => GameStates.playersPlay_selectPlayer]) { _ in self.selectPlayer() }
        machine.addRoutes(event: .dealerHasBlackjack,
                          transitions: [GameStates.dealerBlackjackTest => GameStates.calculateResult]) { _ in self.calculateResult() }
        machine.addRoutes(event: .playerSelected,
                          transitions: [GameStates.playersPlay_selectPlayer => GameStates.playersPlay_selectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .allPlayersFinished,
                          transitions: [GameStates.playersPlay_selectPlayer => GameStates.dealerPlay_getChoice])  { _ in self.dealerGetChoice() }
        machine.addRoutes(event: .playerHandSelected,
                          transitions: [GameStates.playersPlay_selectHand => GameStates.playersPlay_getChoice]) { _ in self.playerGetChoice() }
        machine.addRoutes(event: .playerHandsFinished,
                          transitions: [GameStates.playersPlay_selectHand => GameStates.playersPlay_selectPlayer]) { _ in self.selectPlayer() }
        machine.addRoutes(event: .hitPlayer,
                          transitions: [GameStates.playersPlay_getChoice => GameStates.playersPlay_hit]) { _ in self.hitPlayer() }
        machine.addRoutes(event: .playerChoose,
                          transitions: [GameStates.playersPlay_hit => GameStates.playersPlay_getChoice]) { _ in self.playerGetChoice() }
        machine.addRoutes(event: .playerHasBlackjack,
                          transitions: [GameStates.playersPlay_getChoice => GameStates.playersPlay_selectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .standPlayer,
                          transitions: [GameStates.playersPlay_getChoice => GameStates.playersPlay_selectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .bustPlayer,
                          transitions: [GameStates.playersPlay_getChoice => GameStates.playersPlay_selectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .splitPlayerHand,
                          transitions: [GameStates.playersPlay_getChoice => GameStates.playersPlay_splitHand]) { _ in self.splitHand() }
        machine.addRoutes(event: .playerHandSplitted,
                          transitions: [GameStates.playersPlay_splitHand => GameStates.playersPlay_selectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .hitDealer,
                          transitions: [GameStates.dealerPlay_getChoice => GameStates.dealerPlay_hit])  { _ in self.hitDealer() }
        machine.addRoutes(event: .standDealer,
                          transitions: [GameStates.dealerPlay_getChoice => GameStates.calculateResult]) { context in self.calculateResult() }
        machine.addRoutes(event: .dealerChoose,
                          transitions: [GameStates.dealerPlay_hit => GameStates.dealerPlay_getChoice]) { _ in self.dealerGetChoice() }
        machine.addRoutes(event: .bustDealer,
                          transitions: [GameStates.dealerPlay_getChoice => GameStates.calculateResult]) { context in self.calculateResult() }
        machine.addRoutes(event: .resultsCalculated,
                          transitions: [GameStates.dealerPlay_getChoice => GameStates.distributeBets]) { _ in self.distributeBets() }
        machine.addRoutes(event: .nextRound,
                          transitions: [GameStates.distributeBets => GameStates.checkingDeck]) { _ in self.checkDeck() }
    }
    
    func triggerEvent(_ event: GameEvents) {
        print("Trigger \(event)")
        self.machine <-! event
    }
    
    func start() {
        self.gameEngine.start()
    }
    
    func shuffle() {
        self.gameEngine.shuffle()
    }
    
    func checkDeck() {
        self.gameEngine.checkDeck()
    }
    
    func placeBets() {
        self.gameEngine.placeBets()
    }
    
    func dealCards() {
        self.gameEngine.dealCards()
    }
    
    func dealerBlackjackTest() {
        self.gameEngine.dealerBlackjackTest()
    }
    
    func selectPlayer() {
        self.gameEngine.selectPlayer()
    }
    
    func calculateResult() {
        self.gameEngine.calculateResult()
    }
    
    func selectHand() {
        self.gameEngine.selectHand()
    }
    
    func playerGetChoice() {
        self.gameEngine.playerGetChoice()
    }
    
    func dealerGetChoice() {
        self.gameEngine.dealerGetChoice()
    }
    
    func hitPlayer() {
        self.gameEngine.hitPlayer()
    }
    
    func splitHand() {
        self.gameEngine.splitHand()
    }
    
    func hitDealer() {
        self.gameEngine.hitDealer()
    }

    func distributeBets() {
        self.gameEngine.distributeBets()
    }
}
