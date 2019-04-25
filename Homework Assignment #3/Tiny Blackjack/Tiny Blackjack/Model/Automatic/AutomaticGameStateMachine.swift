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

class AutomaticGameStateMachine {

    let gameEngine: BlackjackProtocol

    let machine = StateMachine<AutomaticGameStates, AutomaticGameEvents>(state: .waitingForStart)

    init(gameEngine: BlackjackProtocol) {
        self.gameEngine = gameEngine

        machine.addRoutes(event: .start, transitions: [.waitingForStart => .started]) { _ in self.start() }
        machine.addRoutes(event: .shuffle, transitions: [.started => .shuffleDeck]) { _ in self.shuffle() }
        machine.addRoutes(event: .shuffled, transitions: [.shuffleDeck => .checkingDeck]) { _ in self.checkDeck() }

        machine.addRoutes(event: .checked, transitions: [.checkingDeck => .playersBetSelectPlayer]) { _ in self.placeBet() }
        machine.addRoutes(event: .noMoreMoney, transitions: [.playersBetSelectPlayer => .finished]) { _ in self.noMoreMoney() }
        machine.addRoutes(event: .playerBetPlaced, transitions: [.playersBetSelectPlayer => .playersBetSelectPlayer]) { _ in self.placeBet() }
        machine.addRoutes(event: .betsPlaced, transitions: [.playersBetSelectPlayer => .allBetsPlaced]) { _ in self.allBetsPlaced() }
        machine.addRoutes(event: .dealCards, transitions: [.allBetsPlaced => .dealCards]) { _ in self.dealCards() }

        machine.addRoutes(event: .dealt, transitions: [.dealCards => .dealerBlackjackTest]) { _ in self.dealerBlackjackTest() }
        machine.addRoutes(event: .dealerHasNoBlackjack, transitions: [.dealerBlackjackTest => .playersPlaySelectPlayer]) { _ in self.selectPlayer() }
        machine.addRoutes(event: .dealerHasBlackjack, transitions: [.dealerBlackjackTest => .showDealerBlackjack]) { _ in self.showDealerBlackjack() }
        machine.addRoutes(event: .dealerHasBlackjackIsShown, transitions: [.showDealerBlackjack => .calculateResult]) { _ in self.calculateResult() }
        machine.addRoutes(event: .playerSelected, transitions: [.playersPlaySelectPlayer => .playersPlaySelectHand]) { _ in self.selectHand(justSplitted: false) }
        machine.addRoutes(event: .allPlayersFinished, transitions: [.playersPlaySelectPlayer => .dealerStart]) { _ in self.dealerStart() }
        machine.addRoutes(event: .turnDealerCardFaceUp, transitions: [.dealerStart => .dealerPlayGetChoice]) { _ in self.dealerGetChoice() }

        machine.addRoutes(event: .playerHandSelected, transitions: [.playersPlaySelectHand => .playersPlayGetChoice]) { _ in self.playerGetChoice() }
        machine.addRoutes(event: .playerHandsFinished, transitions: [.playersPlaySelectHand => .playersPlaySelectPlayer]) { _ in self.selectPlayer() }
        machine.addRoutes(event: .hitPlayer, transitions: [.playersPlayGetChoice => .playersPlayHit]) { _ in self.hitPlayer() }

        machine.addRoutes(event: .playerChoose, transitions: [.playersPlayHit => .playersPlayGetChoice]) { _ in self.playerGetChoice() }

        machine.addRoutes(event: .playerHasBlackjack, transitions: [.playersPlayGetChoice => .playersPlaySelectHand]) { _ in self.selectHand(justSplitted: false) }
        machine.addRoutes(event: .standPlayer, transitions: [.playersPlayGetChoice => .playersPlaySelectHand]) { _ in self.selectHand(justSplitted: false) }
        machine.addRoutes(event: .bustPlayer, transitions: [.playersPlayGetChoice => .playersPlaySelectHand]) { _ in self.selectHand(justSplitted: false) }
        machine.addRoutes(event: .splitPlayerHand, transitions: [.playersPlayGetChoice => .playersPlaySplitHand]) { _ in self.splitHand() }

        machine.addRoutes(event: .playerHandSplitted, transitions: [.playersPlaySplitHand => .showSplittedHand]) { _ in self.showSplittedHand() }
        machine.addRoutes(event: .playerShowSplittedHandFinished, transitions: [.showSplittedHand => .playersPlaySelectHand]) { _ in self.selectHand(justSplitted: true) }

        machine.addRoutes(event: .hitDealer, transitions: [.dealerPlayGetChoice => .dealerPlayHit]) { _ in self.hitDealer() }
        machine.addRoutes(event: .standDealer, transitions: [.dealerPlayGetChoice => .calculateResult]) { _ in self.calculateResult() }
        machine.addRoutes(event: .dealerChoose, transitions: [.dealerPlayHit => .dealerPlayGetChoice]) { _ in self.dealerGetChoice() }
        machine.addRoutes(event: .bustDealer, transitions: [.dealerPlayGetChoice => .calculateResult]) { _ in self.calculateResult() }
        machine.addRoutes(event: .resultsCalculated, transitions: [.calculateResult => .distributeBets]) { _ in self.distributeBets() }
        machine.addRoutes(event: .resultsCalculated, transitions: [.dealerPlayGetChoice => .distributeBets]) { _ in self.distributeBets() }

        machine.addRoutes(event: .noMoreMoney, transitions: [.distributeBets => .started]) { _ in self.start() }
        machine.addRoutes(event: .nextRound, transitions: [.distributeBets => .checkingDeck]) { _ in self.checkDeck() }

        // add errorHandler
        machine.addErrorHandler { context in
            print("[ERROR] \(context.fromState) => \(context.toState) => \(context.event ?? AutomaticGameEvents.start)")
        }
    }

    func triggerEvent(_ event: AutomaticGameEvents) {
        print("--< In state: \(self.machine.state), trigger \(event)")
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

    func placeBet() {
        self.gameEngine.placeBet()
    }

    func allBetsPlaced() {
        self.gameEngine.allBetsPlaced()
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

    func selectHand(justSplitted: Bool) {
        self.gameEngine.selectHand(justSplitted: justSplitted)
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

    func showSplittedHand() {
        self.gameEngine.showSplittedHand()
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
    
    func noMoreMoney() {
        self.gameEngine.noMoreMoney()
    }
}
