//
//  SimpleStrategy.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class SimpleStrategy: BlackjackStrategy {

    func calculateProposedAction(ownHand: Hand, otherHand: Hand) -> ProposedAction {
        
        if ownHand.count == 2 && ownHand.highValue() == 21 {
            return ProposedAction.blackjack
        }
        
        // Split when double ace or double eight
        if ownHand.count == 2 &&
            (ownHand.getRank(cardIndex: 0) == Rank.ace &&
                    ownHand.getRank(cardIndex: 1) == Rank.ace) ||
            (ownHand.getRank(cardIndex: 0) == Rank.eight &&
                    ownHand.getRank(cardIndex: 1) == Rank.eight) {
            return ProposedAction.split
        }

        // 2-2, 3-3, 6-6, 7-7, 9-9: alleen splitsen als de bank 2 t/m 6 heeft
        // Split when double ace or double eight
        if ownHand.count == 2 &&
            (ownHand.getRank(cardIndex: 0) == Rank.two &&
                    ownHand.getRank(cardIndex: 1) == Rank.two) ||
            (ownHand.getRank(cardIndex: 0) == Rank.three &&
                    ownHand.getRank(cardIndex: 1) == Rank.three) ||
            (ownHand.getRank(cardIndex: 0) == Rank.six &&
                    ownHand.getRank(cardIndex: 1) == Rank.six) ||
            (ownHand.getRank(cardIndex: 0) == Rank.seven &&
                    ownHand.getRank(cardIndex: 1) == Rank.seven) ||
            (ownHand.getRank(cardIndex: 0) == Rank.nine &&
                    ownHand.getRank(cardIndex: 1) == Rank.nine) {

            if otherHand.isHard() && otherHand.highValue() <= 6 {
                return ProposedAction.split
            }
        }

        // Stand when above 11 and Dealer 2 t/m 6
        if otherHand.isHard() && otherHand.lowValue() <= 6 {
            if ownHand.isHard() && ownHand.lowValue() >= 12 {
                return ProposedAction.stand
            } else if ownHand.isSoft() && ownHand.highValue() >= 18 {
                return ProposedAction.stand
            }
        }

        // Stand when above 16 and Dealer 7 t/m A
        if otherHand.highValue() <= 11 {
            if ownHand.isHard() && ownHand.lowValue() >= 17 {
                return ProposedAction.stand
            } else if ownHand.isSoft() && ownHand.highValue() >= 19 {
                return ProposedAction.stand
            }
        }
        
        if ownHand.highValue() == 21 || ownHand.lowValue() == 21 {
            return ProposedAction.stand
        }

        return ProposedAction.hit
    }
}

