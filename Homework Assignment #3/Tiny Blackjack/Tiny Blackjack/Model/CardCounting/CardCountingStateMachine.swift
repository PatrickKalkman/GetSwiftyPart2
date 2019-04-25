//
//  CardCountingStateMachine.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 25/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

import SwiftState

class CardCountingStateMachine {
    
    private let engine: CardCountingProtocol
    
    let machine = StateMachine<CountingStates, CountingEvents>(state: .idle)

    init(_ engine: CardCountingProtocol) {
        
        self.engine = engine
        
        machine.addRoutes(event: .start, transitions: [.idle => .getNextPlayerDeal]) { _ in self.engine.getNextPlayerDeal() }
        machine.addRoutes(event: .playerDealt, transitions: [.getNextPlayerDeal => .getNextPlayerDeal]) { _ in self.engine.getNextPlayerDeal() }
        machine.addRoutes(event: .allPlayersDealt, transitions: [.getNextPlayerDeal => .getDealersDeal]) { _ in self.engine.getDealersDeal() }
        machine.addRoutes(event: .dealerDealt, transitions: [.getDealersDeal => .getNextPlayerPlay]) { _ in self.engine.getNextPlayersPlay() }
        machine.addRoutes(event: .handSelected, transitions: [.getNextPlayerPlay => .getNextHand]) { _ in self.engine.getNextHand() }
        machine.addRoutes(event: .presentOptions, transitions: [.getNextHand => .presentOptions]) { _ in self.engine.presentOptions() }
        machine.addRoutes(event: .hit, transitions: [.presentOptions => .hit]) { _ in self.engine.presentOptions() }
        machine.addRoutes(event: .stand, transitions: [.presentOptions => .getNextPlayerPlay]) { _ in self.engine.getNextPlayersPlay() }
        machine.addRoutes(event: .stand, transitions: [.hit => .getNextPlayerPlay]) { _ in self.engine.getNextPlayersPlay() }
    }
    
    func triggerEvent(_ event: CountingEvents) {
        print("--< In state: \(self.machine.state), trigger \(event)")
        self.machine <-! event
    }
    
    func getCurrentState() -> CountingStates {
        return machine.state
    }
    
}



enum CountingStates: StateType {
    case idle
    case getNextPlayerDeal
    case getDealersDeal
    case getNextPlayerPlay
    case getNextHand
    case presentOptions
    case hit
    case stand
    
}

enum CountingEvents: EventType {
    case start
    case playerDealt
    case allPlayersDealt
    case dealerDealt
    case handSelected
    case presentOptions
    case stand
    case hit
}

protocol CardCountingProtocol {
    func getNextPlayerDeal()
    func getDealersDeal()
    func getNextPlayersPlay()
    func getNextHand()
    func presentOptions()
    
}

