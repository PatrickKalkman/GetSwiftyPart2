//
//  DealerStrategy.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

// If the card total is 16 points or lower, the dealer will always draw another card from the deck.
// The dealer will continue drawing cards from the deck until the house hand has at least 17 points, or until it goes
// bust by going over 21. If the dealer has 17 points off the deal without an Ace, most blackjack rules say the dealer
// will stand, even if a 21 player has a higher total.

// The dealer also might have a soft 17 hand, which is one that includes an Ace and any other cards whose combined
// value totals six points. Both land-based casinos and online blackjack casinos who support live dealer blackjack
// require dealers to take at least one more card with the dealer has a soft 17 showing. The dealer will continue
// taking more cards—until the house’s hand either becomes a hard 17 or higher, or the hand goes over 21 and goes bust.

// This class defines the strategy of the dealer
class DealerStrategy: BlackjackStrategyProtocol {

    func calculateProposedAction(ownHand: Hand, otherHand: Hand) -> ProposedAction {

        if otherHand.isBusted() {
            return ProposedAction.stand
        }

        let ownValue: UInt8 = ownHand.getValue()

        if ownHand.count == 2 && ownValue == 21 {
            return ProposedAction.blackjack
        }

        let otherValue: UInt8 = otherHand.getValue()

        if ownValue > otherValue {
            return ProposedAction.stand
        }

        if ownValue <= otherValue && ownValue < 17 {
            return ProposedAction.hit
        }

        if ownValue < otherValue && ownValue >= 17 && ownHand.isHard() {
            return ProposedAction.stand
        }

        if ownValue < otherValue && ownValue >= 17 && ownHand.isSoft() {
            return ProposedAction.hit
        }

        return ProposedAction.dontknow
    }

}
