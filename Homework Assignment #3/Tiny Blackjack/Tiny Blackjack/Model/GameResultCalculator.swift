//
//  GameResultCalculator.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 31/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class GameResultCalculator {
    
    func calculateAndShowResults(players: [Player], dealer: Player) {
        
        for player in players {
            for handIndex in 0...player.numberOfHands() - 1 {
                let playerValue: UInt8 = player.getHand(handIndex: handIndex).getValue()
                let dealerValue: UInt8 = dealer.getHand(handIndex: 0).getValue()
                
                print("\(player.name) value:\(playerValue) hand:\(player.getState())")
                print("\(dealer.name) value:\(dealerValue) hand:\(dealer.getState())")
                
                if dealer.isBusted(handIndex: 0) {
                    print("\(player.name) wins")
                    break
                }
                
                if player.isBusted(handIndex: handIndex) {
                    print("\(dealer.name) wins")
                    break
                }
                
                if dealerValue > playerValue {
                    print("\(dealer.name) wins")
                    break
                }
                
                if dealerValue == playerValue {
                    print("Push")
                    break
                }
                
                if playerValue > dealerValue {
                    print("\(player.name) wins")
                }
            }
        }
    }
    
}
