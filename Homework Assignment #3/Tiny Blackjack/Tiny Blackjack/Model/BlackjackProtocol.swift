//
//  BlackjackProtocol.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 29/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftState

protocol BlackjackProtocol {
    func start()
    func shuffle()
    func checkDeck()
    func placeBet()
    func allBetsPlaced()
    func dealCards()
    func dealerBlackjackTest()
    func showDealerBlackjack()
    func selectPlayer()
    func calculateResult()
    func selectHand(justSplitted: Bool)
    func playerGetChoice()
    func dealerGetChoice()
    func hitPlayer()
    func playerDoubleDown()
    func splitHand()
    func showSplittedHand()
    func hitDealer()
    func distributeBets()
    func dealerStart()
    func noMoreMoney()
}
