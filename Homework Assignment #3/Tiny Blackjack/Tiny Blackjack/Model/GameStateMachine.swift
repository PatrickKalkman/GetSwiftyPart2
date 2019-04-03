//
//  GameStateMachine.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 29/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//
// swiftlint:disable line_length

import Foundation
import SwiftState

class GameStateMachine {

    let gameEngine: BlackjackProtocol

    let machine = StateMachine<GameStates, GameEvents>(state: .waitingForStart)
    
    init(gameEngine: BlackjackProtocol) {
        self.gameEngine = gameEngine

        machine.addRoutes(event: .start, transitions: [GameStates.waitingForStart => GameStates.started]) { _ in self.start() }
        machine.addRoutes(event: .shuffle, transitions: [GameStates.started => GameStates.shuffleDeck]) { _ in self.shuffle() }
        machine.addRoutes(event: .shuffled, transitions: [GameStates.shuffleDeck => GameStates.checkingDeck]) { _ in self.checkDeck() }
        machine.addRoutes(event: .checked, transitions: [GameStates.checkingDeck => GameStates.placeBets]) { _ in self.placeBets() }
        machine.addRoutes(event: .betsPlaced, transitions: [GameStates.placeBets => GameStates.dealCards]) { _ in self.dealCards() }
        machine.addRoutes(event: .dealt, transitions: [GameStates.dealCards => GameStates.dealerBlackjackTest]) { _ in self.dealerBlackjackTest() }
        machine.addRoutes(event: .dealerHasNoBlackjack, transitions: [GameStates.dealerBlackjackTest => GameStates.playersPlaySelectPlayer]) { _ in self.selectPlayer() }
        machine.addRoutes(event: .dealerHasBlackjack, transitions: [GameStates.dealerBlackjackTest => GameStates.showDealerBlackjack]) { _ in self.showDealerBlackjack() }
        machine.addRoutes(event: .dealerHasBlackjackIsShown, transitions: [GameStates.showDealerBlackjack => GameStates.calculateResult]) { _ in self.calculateResult() }
        machine.addRoutes(event: .playerSelected, transitions: [GameStates.playersPlaySelectPlayer => GameStates.playersPlaySelectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .allPlayersFinished, transitions: [GameStates.playersPlaySelectPlayer => GameStates.dealerStart]) { _ in self.dealerStart() }
        machine.addRoutes(event: .turnDealerCardFaceUp, transitions: [GameStates.dealerStart => GameStates.dealerPlayGetChoice]) { _ in self.dealerGetChoice() }
        machine.addRoutes(event: .playerHandSelected, transitions: [GameStates.playersPlaySelectHand => GameStates.playersPlayGetChoice]) { _ in self.playerGetChoice() }
        machine.addRoutes(event: .playerHandsFinished, transitions: [GameStates.playersPlaySelectHand => GameStates.playersPlaySelectPlayer]) { _ in self.selectPlayer() }
        machine.addRoutes(event: .hitPlayer, transitions: [GameStates.playersPlayGetChoice => GameStates.playersPlayHit]) { _ in self.hitPlayer() }
        machine.addRoutes(event: .playerChoose, transitions: [GameStates.playersPlayHit => GameStates.playersPlayGetChoice]) { _ in self.playerGetChoice() }
        machine.addRoutes(event: .playerHasBlackjack, transitions: [GameStates.playersPlayGetChoice => GameStates.playersPlaySelectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .standPlayer, transitions: [GameStates.playersPlayGetChoice => GameStates.playersPlaySelectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .bustPlayer, transitions: [GameStates.playersPlayGetChoice => GameStates.playersPlaySelectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .splitPlayerHand, transitions: [GameStates.playersPlayGetChoice => GameStates.playersPlaySplitHand]) { _ in self.splitHand() }
        machine.addRoutes(event: .playerHandSplitted, transitions: [GameStates.playersPlaySplitHand => GameStates.playersPlaySelectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .doubleDownPlayer, transitions: [GameStates.playersPlayGetChoice => GameStates.playersPlayDoubleDown]) { _ in self.playerDoubleDown() }
        machine.addRoutes(event: .standPlayer, transitions: [GameStates.playersPlayDoubleDown => GameStates.playersPlaySelectHand]) { _ in self.selectHand() }
        machine.addRoutes(event: .hitDealer, transitions: [GameStates.dealerPlayGetChoice => GameStates.dealerPlayHit]) { _ in self.hitDealer() }
        machine.addRoutes(event: .standDealer, transitions: [GameStates.dealerPlayGetChoice => GameStates.calculateResult]) { _ in self.calculateResult() }
        machine.addRoutes(event: .dealerChoose, transitions: [GameStates.dealerPlayHit => GameStates.dealerPlayGetChoice]) { _ in self.dealerGetChoice() }
        machine.addRoutes(event: .bustDealer, transitions: [GameStates.dealerPlayGetChoice => GameStates.calculateResult]) { _ in self.calculateResult() }
        machine.addRoutes(event: .resultsCalculated, transitions: [GameStates.calculateResult => GameStates.distributeBets]) { _ in self.distributeBets() }
        machine.addRoutes(event: .resultsCalculated, transitions: [GameStates.dealerPlayGetChoice => GameStates.distributeBets]) { _ in self.distributeBets() }
        machine.addRoutes(event: .nextRound, transitions: [GameStates.distributeBets => GameStates.checkingDeck]) { _ in self.checkDeck() }
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
    
    func showDealerBlackjack() {
        self.gameEngine.showDealerBlackjack()
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

    func playerDoubleDown() {
        self.gameEngine.playerDoubleDown()
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
    
    func dealerStart() {
        self.gameEngine.dealerStart()
    }
}
