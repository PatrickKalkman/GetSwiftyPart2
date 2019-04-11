//
//  GameResultCalculator.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 31/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class GameResultCalculator {
    
    func calculateAndShowResults(players: [Player], dealer: Player) -> [HandResult] {
        
        var result: [HandResult] = [HandResult]()
        
        var playerIndex: Int = 0
        for player in players {
            
            for handIndex in 0...player.numberOfHands() - 1 {
                let playerValue: UInt8 = player.getHand(handIndex: handIndex).getValue()
                let dealerValue: UInt8 = dealer.getHand(handIndex: 0).getValue()
                
                print("\(player.name) value:\(playerValue) hand:\(player.getState())")
                print("\(dealer.name) value:\(dealerValue) hand:\(dealer.getState())")
                
                var handResult: HandResult = HandResult(playerIndex: playerIndex, handIndex: handIndex, result: GameResult.DealerWins)
                
                if dealer.isBusted(handIndex: 0) {
                    handResult.result = GameResult.PlayerWins
                    result.append(handResult)
                    print("\(player.name) \(handIndex) wins")
                    break;
                }
                
                if player.isBusted(handIndex: handIndex) {
                    handResult.result = GameResult.DealerWins
                    result.append(handResult)
                    print("\(dealer.name) \(handIndex) wins")
                    break
                }
                
                if dealerValue > playerValue {
                    handResult.result = GameResult.DealerWins
                    result.append(handResult)
                    print("\(dealer.name) \(handIndex) wins")
                    break
                }
                
                if dealerValue == playerValue {
                    handResult.result = GameResult.Push
                    result.append(handResult)
                    print("Push \(handIndex)")
                    break
                }
                
                if playerValue > dealerValue {
                    handResult.result = player.getHand(handIndex: handIndex).isBlackjack() ? 
                                            GameResult.PlayerWinsWithBlackjack : GameResult.PlayerWins
                    
                    result.append(handResult)
                    print("\(player.name) wins")
                }
            }
            playerIndex += 1
        }
        
        return result
    }

}
