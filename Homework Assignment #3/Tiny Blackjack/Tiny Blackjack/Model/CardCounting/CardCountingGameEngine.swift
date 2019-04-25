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
        
    }
    
    func getNextHand() {
    }
    
    func presentOptions() {
    }
    
// Helpers that are used by the view
    func start() {
        gameState.triggerEvent(CountingEvents.start)
    }
    
    func gotPlayersDeal() {
        gameState.triggerEvent(CountingEvents.playerDealt)
    }
    
    func gotAllPlayersDeal() {
        gameState.triggerEvent(CountingEvents.allPlayersDealt)
    }
    
    func gotDealersDeal() {
        gameState.triggerEvent(CountingEvents.dealerDealt)
    }
    
    func IsPlayerDealing() -> Bool {
        return gameState.getCurrentState() == CountingStates.getNextPlayerDeal
    }
    
    func IsDealerDealing() -> Bool {
        return gameState.getCurrentState() == CountingStates.getDealersDeal
    }
 
    
    
}
