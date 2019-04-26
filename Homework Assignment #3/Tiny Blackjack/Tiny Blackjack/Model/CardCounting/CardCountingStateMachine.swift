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
        machine.addRoutes(event: .dealerDealt, transitions: [.getDealersDeal => .presentOptions]) { _ in self.engine.presentOptions() }
        machine.addRoutes(event: .hit, transitions: [.presentOptions => .hit]) { _ in self.engine.presentOptions() }
        machine.addRoutes(event: .stand, transitions: [.presentOptions => .presentOptions]) { _ in self.engine.presentOptions() }
        machine.addRoutes(event: .hit, transitions: [.hit => .presentOptions]) { _ in self.engine.presentOptions() }
        machine.addRoutes(event: .getDealerSecondCard, transitions: [.hit => .getDealerSecondCard]) { _ in self.engine.getDealerSecondCard() }
        machine.addRoutes(event: .stand, transitions: [.hit => .presentOptions]) { _ in self.engine.presentOptions() }
        machine.addRoutes(event: .getDealerSecondCard, transitions: [.presentOptions => .getDealerSecondCard]) { _ in self.engine.getDealerSecondCard() }
        machine.addRoutes(event: .gotDealerSecondCard, transitions: [.getDealerSecondCard => .presentDealerOptions]) { _ in self.engine.presentDealerOptions() }
        machine.addRoutes(event: .dealerHit, transitions: [.presentDealerOptions => .dealerHit]) { _ in self.engine.dealerHit() }
        machine.addRoutes(event: .dealerStand, transitions: [.presentDealerOptions => .idle]) { _ in self.engine.dealerStand() }
        machine.addRoutes(event: .dealerStand, transitions: [.dealerHit => .idle]) { _ in self.engine.dealerStand() }
        machine.addRoutes(event: .dealerStand, transitions: [.presentDealerOptions => .idle]) { _ in self.engine.dealerStand() }
    }
    
    func triggerEvent(_ event: CountingEvents) {
        let currentState: CountingStates = self.machine.state
        self.machine <-! event
        let newState: CountingStates = self.machine.state
        print("\(currentState) -> \(newState) : \(event)")
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
    case getDealerSecondCard
    case presentDealerOptions
    case dealerHit
    case dealerStand
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
    case getDealerSecondCard
    case gotDealerSecondCard
    case dealerHit
    case dealerStand
}

protocol CardCountingProtocol {
    func getNextPlayerDeal()
    func getDealersDeal()
    func presentOptions()
    func getDealerSecondCard()
    func getDealerPlay()
    func presentDealerOptions()
    func dealerHit()
    func dealerStand()
}

