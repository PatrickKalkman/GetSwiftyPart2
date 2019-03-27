//
//  DealerStrategy.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

//        If the card total is 16 points or lower, the dealer will always draw another card from the deck. The dealer will continue drawing cards from the deck until the house hand has at least 17 points, or until it goes bust by going over 21. If the dealer has 17 points off the deal without an Ace, most blackjack rules say the dealer will stand, even if a 21 player has a higher total.
//
//        The dealer also might have a soft 17 hand, which is one that includes an Ace and any other cards whose combined value totals six points. Both land-based casinos and online blackjack casinos who support live dealer blackjack require dealers to take at least one more card with the dealer has a soft 17 showing. The dealer will continue taking more cards—until the house’s hand either becomes a hard 17 or higher, or the hand goes over 21 and goes bust.

class DealerStrategy: BlackjackStrategy {

    func calculateProposedAction(ownHand: Hand, otherHand: Hand) -> ProposedAction {

        if ownHand.count == 2 && (ownHand.highValue() == 21 || ownHand.lowValue() == 21) {
            return ProposedAction.blackjack
        }

        if ownHand.isHard() && otherHand.isHard() {
            if ownHand.highValue() <= 21 && ownHand.highValue() > otherHand.highValue() {
                return ProposedAction.stand
            }

            if ownHand.highValue() <= 16 {
                return ProposedAction.hit
            }

            if ownHand.highValue() >= 17 {
                return ProposedAction.stand
            }
        }

        if ownHand.isHard() && otherHand.isSoft() {
            if ownHand.highValue() <= 21 && ownHand.highValue() > otherHand.lowValue() {
                return ProposedAction.stand
            }

            if ownHand.highValue() <= 16 {
                return ProposedAction.hit
            }

            if ownHand.highValue() >= 17 {
                return ProposedAction.stand
            }
        }

        if ownHand.isSoft() && otherHand.isHard() {
            if ownHand.lowValue() <= 21 && ownHand.lowValue() > otherHand.highValue() {
                return ProposedAction.stand
            }

            if ownHand.lowValue() <= 16 {
                return ProposedAction.hit
            }

            if ownHand.lowValue() >= 17 {
                return ProposedAction.stand
            }
        }

        if ownHand.isSoft() && otherHand.isSoft() {
            if ownHand.lowValue() <= 21 && ownHand.lowValue() > otherHand.lowValue() {
                return ProposedAction.stand
            }

            if ownHand.lowValue() <= 16 {
                return ProposedAction.hit
            }

            if ownHand.lowValue() >= 17 {
                return ProposedAction.stand
            }
        }

        return ProposedAction.dontknow
    }

}
