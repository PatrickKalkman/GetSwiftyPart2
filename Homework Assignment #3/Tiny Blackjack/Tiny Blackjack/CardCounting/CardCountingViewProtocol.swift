//
//  CardCountingViewProtocol.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 25/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

protocol CardCountingViewProtocol {
    
    func getNextPlayerDeal()
    func getDealersDeal()
    func showSplittedHand()
    func presentOptions()
    func getDealersSecondCard()
    func presentDealerOptions()
    func presentNextRound()
    func resetCardIndex()
    
}
