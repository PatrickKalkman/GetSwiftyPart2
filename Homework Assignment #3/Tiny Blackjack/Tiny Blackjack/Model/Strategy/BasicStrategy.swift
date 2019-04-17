//
//  SimpleStrategy.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

// This class is responsible for implementing basic strategy
class BasicStrategy: BlackjackStrategyProtocol {

    var hardMatrix: [CardCombi: ProposedAction] = [CardCombi: ProposedAction]()
    var softMatrix: [CardCombi: ProposedAction] = [CardCombi: ProposedAction]()
    var splitMatrix: [CardCombi: ProposedAction] = [CardCombi: ProposedAction]()
    
    init() {
        initHardMatrix()
        initSoftMatrix()
        initSplitMatrix()
    }
    
    func calculateProposedAction(ownHand: Hand, otherHand: Hand) -> ProposedAction {
        
        if ownHand.count == 2 && ownHand.highValue() == 21 {
            return ProposedAction.blackjack
        }

        let cardCombi: CardCombi = CardCombi(ownHand.highValue(), otherHand.highValue())
        
        if ownHand.containsSameRank() {
            if let proposedAction = splitMatrix[cardCombi] {
                return proposedAction
            }
        }
        
        if ownHand.isHard() {
            if let proposedAction = hardMatrix[cardCombi] {
                return proposedAction
            }
        }
        
        if ownHand.isSoft() {
            if let proposedAction = softMatrix[cardCombi] {
                return proposedAction
            }
        }
        
        return ProposedAction.dontknow
    }
    
    func initSplitMatrix() {
        
        // Player 4
        splitMatrix[CardCombi(4, 2)] = ProposedAction.splitOrHit
        splitMatrix[CardCombi(4, 3)] = ProposedAction.splitOrHit
        splitMatrix[CardCombi(4, 4)] = ProposedAction.split
        splitMatrix[CardCombi(4, 5)] = ProposedAction.split
        splitMatrix[CardCombi(4, 6)] = ProposedAction.split
        splitMatrix[CardCombi(4, 7)] = ProposedAction.split
        splitMatrix[CardCombi(4, 8)] = ProposedAction.hit
        splitMatrix[CardCombi(4, 9)] = ProposedAction.hit
        splitMatrix[CardCombi(4, 10)] = ProposedAction.hit
        splitMatrix[CardCombi(4, 11)] = ProposedAction.hit
        
        // Player 6
        splitMatrix[CardCombi(6, 2)] = ProposedAction.splitOrHit
        splitMatrix[CardCombi(6, 3)] = ProposedAction.splitOrHit
        splitMatrix[CardCombi(6, 4)] = ProposedAction.split
        splitMatrix[CardCombi(6, 5)] = ProposedAction.split
        splitMatrix[CardCombi(6, 6)] = ProposedAction.split
        splitMatrix[CardCombi(6, 7)] = ProposedAction.split
        splitMatrix[CardCombi(6, 8)] = ProposedAction.hit
        splitMatrix[CardCombi(6, 9)] = ProposedAction.hit
        splitMatrix[CardCombi(6, 10)] = ProposedAction.hit
        splitMatrix[CardCombi(6, 11)] = ProposedAction.hit
        
        // Player 8
        splitMatrix[CardCombi(8, 2)] = ProposedAction.hit
        splitMatrix[CardCombi(8, 3)] = ProposedAction.hit
        splitMatrix[CardCombi(8, 4)] = ProposedAction.hit
        splitMatrix[CardCombi(8, 5)] = ProposedAction.splitOrHit
        splitMatrix[CardCombi(8, 6)] = ProposedAction.splitOrHit
        splitMatrix[CardCombi(8, 7)] = ProposedAction.hit
        splitMatrix[CardCombi(8, 8)] = ProposedAction.hit
        splitMatrix[CardCombi(8, 9)] = ProposedAction.hit
        splitMatrix[CardCombi(8, 10)] = ProposedAction.hit
        splitMatrix[CardCombi(8, 11)] = ProposedAction.hit
        
        // Player 12
        splitMatrix[CardCombi(12, 2)] = ProposedAction.splitOrHit
        splitMatrix[CardCombi(12, 3)] = ProposedAction.split
        splitMatrix[CardCombi(12, 4)] = ProposedAction.split
        splitMatrix[CardCombi(12, 5)] = ProposedAction.split
        splitMatrix[CardCombi(12, 6)] = ProposedAction.split
        splitMatrix[CardCombi(12, 7)] = ProposedAction.hit
        splitMatrix[CardCombi(12, 8)] = ProposedAction.hit
        splitMatrix[CardCombi(12, 9)] = ProposedAction.hit
        splitMatrix[CardCombi(12, 10)] = ProposedAction.hit
        splitMatrix[CardCombi(12, 11)] = ProposedAction.hit
        
        // Player 14
        splitMatrix[CardCombi(14, 2)] = ProposedAction.split
        splitMatrix[CardCombi(14, 3)] = ProposedAction.split
        splitMatrix[CardCombi(14, 4)] = ProposedAction.split
        splitMatrix[CardCombi(14, 5)] = ProposedAction.split
        splitMatrix[CardCombi(14, 6)] = ProposedAction.split
        splitMatrix[CardCombi(14, 7)] = ProposedAction.split
        splitMatrix[CardCombi(14, 8)] = ProposedAction.hit
        splitMatrix[CardCombi(14, 9)] = ProposedAction.hit
        splitMatrix[CardCombi(14, 10)] = ProposedAction.hit
        splitMatrix[CardCombi(14, 11)] = ProposedAction.hit
        
        // Player 16
        splitMatrix[CardCombi(16, 2)] = ProposedAction.split
        splitMatrix[CardCombi(16, 3)] = ProposedAction.split
        splitMatrix[CardCombi(16, 4)] = ProposedAction.split
        splitMatrix[CardCombi(16, 5)] = ProposedAction.split
        splitMatrix[CardCombi(16, 6)] = ProposedAction.split
        splitMatrix[CardCombi(16, 7)] = ProposedAction.split
        splitMatrix[CardCombi(16, 8)] = ProposedAction.hit
        splitMatrix[CardCombi(16, 9)] = ProposedAction.hit
        splitMatrix[CardCombi(16, 10)] = ProposedAction.hit
        splitMatrix[CardCombi(16, 11)] = ProposedAction.surrenderOrSplit
        
        // Player 18
        splitMatrix[CardCombi(18, 2)] = ProposedAction.split
        splitMatrix[CardCombi(18, 3)] = ProposedAction.split
        splitMatrix[CardCombi(18, 4)] = ProposedAction.split
        splitMatrix[CardCombi(18, 5)] = ProposedAction.split
        splitMatrix[CardCombi(18, 6)] = ProposedAction.split
        splitMatrix[CardCombi(18, 7)] = ProposedAction.stand
        splitMatrix[CardCombi(18, 8)] = ProposedAction.split
        splitMatrix[CardCombi(18, 9)] = ProposedAction.split
        splitMatrix[CardCombi(18, 10)] = ProposedAction.stand
        splitMatrix[CardCombi(18, 11)] = ProposedAction.stand
        
        // Player 2
        splitMatrix[CardCombi(22, 2)] = ProposedAction.split
        splitMatrix[CardCombi(22, 3)] = ProposedAction.split
        splitMatrix[CardCombi(22, 4)] = ProposedAction.split
        splitMatrix[CardCombi(22, 5)] = ProposedAction.split
        splitMatrix[CardCombi(22, 6)] = ProposedAction.split
        splitMatrix[CardCombi(22, 7)] = ProposedAction.split
        splitMatrix[CardCombi(22, 8)] = ProposedAction.split
        splitMatrix[CardCombi(22, 9)] = ProposedAction.split
        splitMatrix[CardCombi(22, 10)] = ProposedAction.split
        splitMatrix[CardCombi(22, 11)] = ProposedAction.split
    }
    
    func initSoftMatrix() {
        
        // Player 13
        softMatrix[CardCombi(13, 2)] = ProposedAction.hit
        softMatrix[CardCombi(13, 3)] = ProposedAction.hit
        softMatrix[CardCombi(13, 4)] = ProposedAction.hit
        softMatrix[CardCombi(13, 5)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(13, 6)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(13, 7)] = ProposedAction.hit
        softMatrix[CardCombi(13, 8)] = ProposedAction.hit
        softMatrix[CardCombi(13, 9)] = ProposedAction.hit
        softMatrix[CardCombi(13, 10)] = ProposedAction.hit
        softMatrix[CardCombi(13, 11)] = ProposedAction.hit
        
        // Player 14
        softMatrix[CardCombi(14, 2)] = ProposedAction.hit
        softMatrix[CardCombi(14, 3)] = ProposedAction.hit
        softMatrix[CardCombi(14, 4)] = ProposedAction.hit
        softMatrix[CardCombi(14, 5)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(14, 6)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(14, 7)] = ProposedAction.hit
        softMatrix[CardCombi(14, 8)] = ProposedAction.hit
        softMatrix[CardCombi(14, 9)] = ProposedAction.hit
        softMatrix[CardCombi(14, 10)] = ProposedAction.hit
        softMatrix[CardCombi(14, 11)] = ProposedAction.hit
        
        // Player 15
        softMatrix[CardCombi(15, 2)] = ProposedAction.hit
        softMatrix[CardCombi(15, 3)] = ProposedAction.hit
        softMatrix[CardCombi(15, 4)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(15, 5)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(15, 6)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(15, 7)] = ProposedAction.hit
        softMatrix[CardCombi(15, 8)] = ProposedAction.hit
        softMatrix[CardCombi(15, 9)] = ProposedAction.hit
        softMatrix[CardCombi(15, 10)] = ProposedAction.hit
        softMatrix[CardCombi(15, 11)] = ProposedAction.hit
        
        // Player 16
        softMatrix[CardCombi(16, 2)] = ProposedAction.hit
        softMatrix[CardCombi(16, 3)] = ProposedAction.hit
        softMatrix[CardCombi(16, 4)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(16, 5)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(16, 6)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(16, 7)] = ProposedAction.hit
        softMatrix[CardCombi(16, 8)] = ProposedAction.hit
        softMatrix[CardCombi(16, 9)] = ProposedAction.hit
        softMatrix[CardCombi(16, 10)] = ProposedAction.hit
        softMatrix[CardCombi(16, 11)] = ProposedAction.hit
        
        // Player 17
        softMatrix[CardCombi(17, 2)] = ProposedAction.hit
        softMatrix[CardCombi(17, 3)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(17, 4)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(17, 5)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(17, 6)] = ProposedAction.doubleOrHit
        softMatrix[CardCombi(17, 7)] = ProposedAction.hit
        softMatrix[CardCombi(17, 8)] = ProposedAction.hit
        softMatrix[CardCombi(17, 9)] = ProposedAction.hit
        softMatrix[CardCombi(17, 10)] = ProposedAction.hit
        softMatrix[CardCombi(17, 11)] = ProposedAction.hit
        
        // Player 18
        softMatrix[CardCombi(18, 2)] = ProposedAction.doubleOrStand
        softMatrix[CardCombi(18, 3)] = ProposedAction.doubleOrStand
        softMatrix[CardCombi(18, 4)] = ProposedAction.doubleOrStand
        softMatrix[CardCombi(18, 5)] = ProposedAction.doubleOrStand
        softMatrix[CardCombi(18, 6)] = ProposedAction.doubleOrStand
        softMatrix[CardCombi(18, 7)] = ProposedAction.stand
        softMatrix[CardCombi(18, 8)] = ProposedAction.stand
        softMatrix[CardCombi(18, 9)] = ProposedAction.hit
        softMatrix[CardCombi(18, 10)] = ProposedAction.hit
        softMatrix[CardCombi(18, 11)] = ProposedAction.hit
        
        // Player 19
        softMatrix[CardCombi(19, 2)] = ProposedAction.stand
        softMatrix[CardCombi(19, 3)] = ProposedAction.stand
        softMatrix[CardCombi(19, 4)] = ProposedAction.stand
        softMatrix[CardCombi(19, 5)] = ProposedAction.stand
        softMatrix[CardCombi(19, 6)] = ProposedAction.doubleOrStand
        softMatrix[CardCombi(19, 7)] = ProposedAction.stand
        softMatrix[CardCombi(19, 8)] = ProposedAction.stand
        softMatrix[CardCombi(19, 9)] = ProposedAction.stand
        softMatrix[CardCombi(19, 10)] = ProposedAction.stand
        softMatrix[CardCombi(19, 11)] = ProposedAction.stand
        
        // Player: 18-21 -> Stand
        for playerValue in 20...21 {
            for dealerValue in 2...11 {
                softMatrix[CardCombi(UInt8(playerValue), UInt8(dealerValue))] = ProposedAction.stand
            }
        }
    }
    
    func initHardMatrix() {
        
        // Player: 4-8 -> Hit
        for playerValue in 4...8 {
            for dealerValue in 2...11 {
                hardMatrix[CardCombi(UInt8(playerValue), UInt8(dealerValue))] = ProposedAction.hit
            }
        }
        
        // Player 9
        hardMatrix[CardCombi(9, 2)] = ProposedAction.hit
        hardMatrix[CardCombi(9, 3)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(9, 4)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(9, 5)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(9, 6)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(9, 7)] = ProposedAction.hit
        hardMatrix[CardCombi(9, 8)] = ProposedAction.hit
        hardMatrix[CardCombi(9, 9)] = ProposedAction.hit
        hardMatrix[CardCombi(9, 10)] = ProposedAction.hit
        hardMatrix[CardCombi(9, 11)] = ProposedAction.hit
        
        // Player 10
        hardMatrix[CardCombi(10, 2)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(10, 3)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(10, 4)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(10, 5)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(10, 6)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(10, 7)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(10, 8)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(10, 9)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(10, 10)] = ProposedAction.hit
        hardMatrix[CardCombi(10, 11)] = ProposedAction.hit
        
        // Player 11
        hardMatrix[CardCombi(11, 2)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(11, 3)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(11, 4)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(11, 5)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(11, 6)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(11, 7)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(11, 8)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(11, 9)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(11, 10)] = ProposedAction.doubleOrHit
        hardMatrix[CardCombi(11, 11)] = ProposedAction.doubleOrHit
        
        // Player 12
        hardMatrix[CardCombi(12, 2)] = ProposedAction.hit
        hardMatrix[CardCombi(12, 3)] = ProposedAction.hit
        hardMatrix[CardCombi(12, 4)] = ProposedAction.stand
        hardMatrix[CardCombi(12, 5)] = ProposedAction.stand
        hardMatrix[CardCombi(12, 6)] = ProposedAction.stand
        hardMatrix[CardCombi(12, 7)] = ProposedAction.hit
        hardMatrix[CardCombi(12, 8)] = ProposedAction.hit
        hardMatrix[CardCombi(12, 9)] = ProposedAction.hit
        hardMatrix[CardCombi(12, 10)] = ProposedAction.hit
        hardMatrix[CardCombi(12, 11)] = ProposedAction.hit
        
        // Player 13
        hardMatrix[CardCombi(13, 2)] = ProposedAction.stand
        hardMatrix[CardCombi(13, 3)] = ProposedAction.stand
        hardMatrix[CardCombi(13, 4)] = ProposedAction.stand
        hardMatrix[CardCombi(13, 5)] = ProposedAction.stand
        hardMatrix[CardCombi(13, 6)] = ProposedAction.stand
        hardMatrix[CardCombi(13, 7)] = ProposedAction.hit
        hardMatrix[CardCombi(13, 8)] = ProposedAction.hit
        hardMatrix[CardCombi(13, 9)] = ProposedAction.hit
        hardMatrix[CardCombi(13, 10)] = ProposedAction.hit
        hardMatrix[CardCombi(13, 11)] = ProposedAction.hit
        
        // Player 14
        hardMatrix[CardCombi(14, 2)] = ProposedAction.stand
        hardMatrix[CardCombi(14, 3)] = ProposedAction.stand
        hardMatrix[CardCombi(14, 4)] = ProposedAction.stand
        hardMatrix[CardCombi(14, 5)] = ProposedAction.stand
        hardMatrix[CardCombi(14, 6)] = ProposedAction.stand
        hardMatrix[CardCombi(14, 7)] = ProposedAction.hit
        hardMatrix[CardCombi(14, 8)] = ProposedAction.hit
        hardMatrix[CardCombi(14, 9)] = ProposedAction.hit
        hardMatrix[CardCombi(14, 10)] = ProposedAction.hit
        hardMatrix[CardCombi(14, 11)] = ProposedAction.hit
        
        // Player 15
        hardMatrix[CardCombi(15, 2)] = ProposedAction.stand
        hardMatrix[CardCombi(15, 3)] = ProposedAction.stand
        hardMatrix[CardCombi(15, 4)] = ProposedAction.stand
        hardMatrix[CardCombi(15, 5)] = ProposedAction.stand
        hardMatrix[CardCombi(15, 6)] = ProposedAction.stand
        hardMatrix[CardCombi(15, 7)] = ProposedAction.hit
        hardMatrix[CardCombi(15, 8)] = ProposedAction.hit
        hardMatrix[CardCombi(15, 9)] = ProposedAction.hit
        hardMatrix[CardCombi(15, 10)] = ProposedAction.surrenderOrHit
        hardMatrix[CardCombi(15, 11)] = ProposedAction.surrenderOrHit
        
        // Player 16
        hardMatrix[CardCombi(16, 2)] = ProposedAction.stand
        hardMatrix[CardCombi(16, 3)] = ProposedAction.stand
        hardMatrix[CardCombi(16, 4)] = ProposedAction.stand
        hardMatrix[CardCombi(16, 5)] = ProposedAction.stand
        hardMatrix[CardCombi(16, 6)] = ProposedAction.stand
        hardMatrix[CardCombi(16, 7)] = ProposedAction.hit
        hardMatrix[CardCombi(16, 8)] = ProposedAction.hit
        hardMatrix[CardCombi(16, 9)] = ProposedAction.surrenderOrHit
        hardMatrix[CardCombi(16, 10)] = ProposedAction.surrenderOrHit
        hardMatrix[CardCombi(16, 11)] = ProposedAction.surrenderOrHit
        
        // Player 17
        hardMatrix[CardCombi(17, 2)] = ProposedAction.stand
        hardMatrix[CardCombi(17, 3)] = ProposedAction.stand
        hardMatrix[CardCombi(17, 4)] = ProposedAction.stand
        hardMatrix[CardCombi(17, 5)] = ProposedAction.stand
        hardMatrix[CardCombi(17, 6)] = ProposedAction.stand
        hardMatrix[CardCombi(17, 7)] = ProposedAction.stand
        hardMatrix[CardCombi(17, 8)] = ProposedAction.stand
        hardMatrix[CardCombi(17, 9)] = ProposedAction.stand
        hardMatrix[CardCombi(17, 10)] = ProposedAction.stand
        hardMatrix[CardCombi(17, 11)] = ProposedAction.surrenderOrStand
        
        // Player: 18-21 -> Stand
        for playerValue in 18...21 {
            for dealerValue in 2...11 {
                hardMatrix[CardCombi(UInt8(playerValue), UInt8(dealerValue))] = ProposedAction.stand
            }
        }
    }

}

struct CardCombi: Hashable {
    var playerValue: UInt8
    var dealerValue: UInt8
    
    init(_ playerValue: UInt8, _ dealerValue: UInt8) {
        self.playerValue = playerValue
        self.dealerValue = dealerValue
    }
}
