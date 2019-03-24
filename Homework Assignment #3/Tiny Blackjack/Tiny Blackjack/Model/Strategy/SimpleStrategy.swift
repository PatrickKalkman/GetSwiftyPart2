//
//  SimpleStrategy.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation



class SimpleStrategy: BlackjackStrategy {
    
    func calculateProposedAction(playerHand: Hand, dealerHand: Hand) -> ProposedAction {
        

        // Split when double ace or double eight
        if playerHand.count == 2 &&
            (playerHand.getRank(cardIndex: 0) == Rank.ace &&
            playerHand.getRank(cardIndex: 1) == Rank.ace) ||
            (playerHand.getRank(cardIndex: 0) == Rank.eight &&
             playerHand.getRank(cardIndex: 1) == Rank.eight) {
            return ProposedAction.split
        }
        
//                2-2, 3-3, 6-6, 7-7, 9-9: alleen splitsen als de bank 2 t/m 6 heeft
        // Split when double ace or double eight
        if playerHand.count == 2 &&
            (playerHand.getRank(cardIndex: 0) == Rank.two &&
                playerHand.getRank(cardIndex: 1) == Rank.two) ||
            (playerHand.getRank(cardIndex: 0) == Rank.three &&
                playerHand.getRank(cardIndex: 1) == Rank.three) ||
            (playerHand.getRank(cardIndex: 0) == Rank.six &&
                playerHand.getRank(cardIndex: 1) == Rank.six) ||
            (playerHand.getRank(cardIndex: 0) == Rank.seven &&
                playerHand.getRank(cardIndex: 1) == Rank.seven) ||
            (playerHand.getRank(cardIndex: 0) == Rank.nine &&
            playerHand.getRank(cardIndex: 1) == Rank.nine) {
            
            if dealerHand.isHard() && dealerHand.lowValue() <= 6 {
                return ProposedAction.split
            }
        }
        
        
        // Stand when above 11 and Dealer 2 t/m 6
        if dealerHand.isHard() && dealerHand.lowValue() <= 6 {
            if playerHand.isHard() && playerHand.lowValue() >= 12 {
                return ProposedAction.stand
            } else if playerHand.isSoft() &&  playerHand.highValue() >= 18 {
                return ProposedAction.stand
            }
        }
        
        // Stand when above 16 and Dealer 7 t/m A
        if dealerHand.highValue() <= 11 {
            if playerHand.isHard() && playerHand.lowValue() >= 17 {
                return ProposedAction.stand
            } else if playerHand.isSoft() && playerHand.highValue() >= 19 {
                return ProposedAction.stand
            }
        }
        
        
        return ProposedAction.dontknow
    }

}

