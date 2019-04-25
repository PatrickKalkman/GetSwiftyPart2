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

    private var gameState: CardCountingStateMachine!
    private var view: CardCountingViewProtocol!
    private var players: [Player] = [Player]()
    private var dealer: Player = Player(name: "Dealer", strategy: DealerStrategy(), isDealer: true, isHuman: true)
    
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
    
    func getNextPlayersPlay() {
        view.getNextPlayersPlay()
    }
    
    func getNextHand() {
    }
    
    func presentOptions() {
        view.presentOptions()
    }
    
// Helpers that are used by the view
    func start(numberOfPlayers: UInt) {
        createPlayers(numberOfPlayers)
        gameState.triggerEvent(CountingEvents.start)
    }
    
    func createPlayers(_ numberOfPlayers: UInt) {
        for playerIndex in 1...numberOfPlayers {
            let player: Player = Player(name: "player \(playerIndex)", strategy: BasicStrategy(), isDealer: false, isHuman: true)
            players.append(player)
        }
    }
    
    func gotPlayersDeal(_ playerIndex: Int, _ dealtCards: [Card]) {
        players[playerIndex].add(handIndex: 0, card: dealtCards[0])
        players[playerIndex].add(handIndex: 0, card: dealtCards[1])
        gameState.triggerEvent(CountingEvents.playerDealt)
    }
    
    func gotAllPlayersDeal() {
        gameState.triggerEvent(CountingEvents.allPlayersDealt)
    }
    
    func gotDealersDeal(_ dealerCard: Card) {
        dealer.add(handIndex: 0, card: dealerCard)
        gameState.triggerEvent(CountingEvents.dealerDealt)
    }
    
    func selectHand() {
        gameState.triggerEvent(CountingEvents.handSelected)
        view.getNextHand()
    }
    
    func shouldPresentOptions() {
        gameState.triggerEvent(CountingEvents.presentOptions)
    }
    
    func hit() {
        gameState.triggerEvent(CountingEvents.hit)
    }
    
    func stand() {
        gameState.triggerEvent(CountingEvents.stand)
    }
   
    func IsPlayerDealing() -> Bool {
        return gameState.getCurrentState() == CountingStates.getNextPlayerDeal
    }
    
    func IsDealerDealing() -> Bool {
        return gameState.getCurrentState() == CountingStates.getDealersDeal
    }
 
    func isPlayerPlaying() -> Bool {
        return gameState.getCurrentState() == CountingStates.getNextPlayerPlay
    }
    
    func isHit() -> Bool {
        return gameState.getCurrentState() == CountingStates.hit
    }
 
}
