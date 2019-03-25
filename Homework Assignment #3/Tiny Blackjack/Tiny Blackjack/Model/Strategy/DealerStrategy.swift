//
//  DealerStrategy.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class DealerStrategy: BlackjackStrategy {

    func calculateProposedAction(playerHand: Hand, dealerHand: Hand) -> ProposedAction {
        return ProposedAction.stand
    }
}
