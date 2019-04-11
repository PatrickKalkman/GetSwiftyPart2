//
//  SimpleStrategy.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class BasicStrategy: BlackjackStrategy {

    func calculateProposedAction(ownHand: Hand, otherHand: Hand) -> ProposedAction {

        return ProposedAction.hit
    }

}
