//
//  CardCountingGameEngine.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 25/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftState

class CardCountingGameEngine: CardCountingProtocol {
    
    private let cardCountCalculator: CardCountCalculator = CardCountCalculator()
    private var gameState: CardCountingStateMachine!
    private var view: CardCountingViewProtocol!
    private var players: [Player] = [Player]()
    private var dealer: Player = Player(name: "Dealer", strategy: DealerStrategy(), isDealer: true, isHuman: true)
    
    var playerIndex: Int = 0
    var numberOfPlayers: UInt = 0
    
    func nextPlayer() {
        playerIndex += 1
    }
    
    func resetPlayerIndex() {
        playerIndex = 0
    }
    
    func playerNumber() -> String {
        return String(playerIndex + 1)
    }
    
    func playersLeft() -> Bool {
         return playerIndex < numberOfPlayers - 1
    }
    
    init(view: CardCountingViewProtocol) {
        self.gameState = CardCountingStateMachine(self)
        self.view = view
    }
    
    // Protocol for calling the view
    func getNextPlayerDeal() {
        view.getNextPlayerDeal()
    }
    
    func getDealersDeal() {
        view.getDealersDeal()
    }
    
    func presentOptions() {
        view.presentOptions()
    }
    
    func getDealerSecondCard() {
        view.getDealersSecondCard()
    }
    
    func getDealerPlay() {
    }
    
    func presentDealerOptions() {
        view.presentDealerOptions()
    }
    
    func dealerHit() {
        view.presentDealerOptions()
    }
    
    // Helpers that are used by the view
    func start(numberOfPlayers: UInt, numberOfDecksRemaining: UInt) {
        self.numberOfPlayers = numberOfPlayers
        cardCountCalculator.start(remainingDecks: Int(numberOfDecksRemaining))
        createPlayers(numberOfPlayers)
        gameState.triggerEvent(CountingEvents.start)
    }
    
    func getPlayerValue() -> UInt8 {
        return players[playerIndex].getHand(handIndex: 0).getValue()
    }
    
    func getDealerValue() -> UInt8 {
        return dealer.getHand(handIndex: 0).getValue()
    }
    
    func getStrategyMessage() -> (ProposedAction, String) {
        let proposedAction: ProposedAction = players[playerIndex].askAction(handIndex: 0, dealerHand: dealer.getHand(handIndex: 0))
    
        var proposedMessage: String = "Basic strategy says to: "
        
        switch proposedAction {
        case .stand:
                proposedMessage += "stand"
        case .hit:
                proposedMessage += "hit"
        case .double:
                proposedMessage += "double"
        case .doubleOrHit:
                proposedMessage += "double or hit"
        case .doubleOrStand:
                proposedMessage += "double or stand"
        case .split:
                proposedMessage += "split"
        case .splitOrHit:
                proposedMessage += "split or hit"
        case .surrender:
                proposedMessage += "surrender"
        case .surrenderOrHit:
                proposedMessage += "surrender or hit"
        case .surrenderOrStand:
                proposedMessage += "surrender or stand"
        case .surrenderOrSplit:
                proposedMessage += "surrender or split"
        case .blackjack:
                proposedMessage += "stand (blackjack)"
        case .bust:
                proposedMessage += "stand (bust)"
        case .dontknow:
                proposedMessage += "stand"
        }
        
        return (proposedAction, proposedMessage)
    }
    
    func nextRound() {
        clearPlayersAndDealer()
        gameState.triggerEvent(CountingEvents.start)
    }
    
    func createPlayers(_ numberOfPlayers: UInt) {
        for playerIndex in 1...numberOfPlayers {
            let player: Player = Player(name: "player \(playerIndex)", strategy: BasicStrategy(), isDealer: false, isHuman: true)
            players.append(player)
        }
    }
    
    func clearPlayersAndDealer() {
        for player in players {
            player.clear()
        }
        dealer.clear()
    }
    
    func gotPlayersDeal(_ playerIndex: Int, _ dealtCards: [Card]) {
        storePlayersDeal(playerIndex, dealtCards)
        nextPlayer()
        gameState.triggerEvent(CountingEvents.playerDealt)
    }
    
    func storePlayersDeal(_ playerIndex: Int, _ dealtCards: [Card]) {
        players[playerIndex].add(handIndex: 0, card: dealtCards[0])
        players[playerIndex].add(handIndex: 0, card: dealtCards[1])
        cardCountCalculator.addCards(card: dealtCards[0])
        cardCountCalculator.addCards(card: dealtCards[1])
    }
    
    func gotAllPlayersDeal() {
        gameState.triggerEvent(CountingEvents.allPlayersDealt)
    }
    
    func gotDealersDeal(_ dealerCard: Card) {
        dealer.add(handIndex: 0, card: dealerCard)
        cardCountCalculator.addCards(card: dealerCard)
        resetPlayerIndex()
        gameState.triggerEvent(CountingEvents.dealerDealt)
    }
    
    func gotDealersSecondCard(_ dealerCard: Card) {
        dealer.add(handIndex: 0, card: dealerCard)
        cardCountCalculator.addCards(card: dealerCard)
        resetPlayerIndex()
        gameState.triggerEvent(CountingEvents.gotDealerSecondCard)
    }

    func gotDealerCard(_ dealerCard: Card) {
        dealer.add(handIndex: 0, card: dealerCard)
        cardCountCalculator.addCards(card: dealerCard)
    }
    
    func gotPlayerCard(_ playerCard: Card) {
        players[playerIndex].add(handIndex: 0, card: playerCard)
        cardCountCalculator.addCards(card: playerCard)
    }
    
    func selectDealer() {
        gameState.triggerEvent(CountingEvents.getDealerSecondCard)
    }
    
    func shouldPresentOptions() {
        gameState.triggerEvent(CountingEvents.presentOptions)
    }
    
    func hit() {
        if checkState(CountingStates.presentOptions) {
            gameState.triggerEvent(CountingEvents.hit)
        } else {
            gameState.triggerEvent(CountingEvents.dealerHit)
        }
    }
    
    func stand() {
        if checkState(CountingStates.presentOptions) || checkState(CountingStates.hit) {
            if playersLeft() {
                view.resetCardIndex()
                nextPlayer()
                gameState.triggerEvent(CountingEvents.stand)
            } else {
                gameState.triggerEvent(CountingEvents.getDealerSecondCard)
            }
        } else if checkState(CountingStates.presentDealerOptions) || checkState(CountingStates.dealerHit) {
            gameState.triggerEvent(CountingEvents.dealerStand)
        }
    }
    
    func dealerStand() {
        view.presentNextRound()
    }
   
    func IsPlayerDealing() -> Bool {
        return checkState(CountingStates.getNextPlayerDeal)
    }
    
    func IsDealerDealing() -> Bool {
        return checkState(CountingStates.getDealersDeal)
    }
 
    func isPlayerPlaying() -> Bool {
        return checkState(CountingStates.getNextPlayerPlay)
    }
    
    func isHit() -> Bool {
        return checkState(CountingStates.hit)
    }
    
    func isDealerHit() -> Bool {
        return checkState(CountingStates.dealerHit)
    }
    
    func isSecondDealerCard() -> Bool {
        return checkState(CountingStates.getDealerSecondCard)
    }
    
    func checkState(_ stateToCheck: CountingStates) -> Bool {
        return gameState.getCurrentState() == stateToCheck
    }
 
    func calculateRunningCount() -> Int {
        return cardCountCalculator.calculateRunningCount()
    }
    
    func calculateTrueCount() -> Int {
        return cardCountCalculator.calculateTrueCount()
    }
    
    func getBettingUnits() -> UInt {
        return cardCountCalculator.getBettingUnits()
    }
    
}
