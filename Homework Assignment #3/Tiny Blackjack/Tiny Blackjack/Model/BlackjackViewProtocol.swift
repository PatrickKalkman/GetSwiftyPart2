//
//  BlackjackViewProtocol.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 31/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

protocol BlackjackViewProtocol {
    func start()
    func shuffle()
    func placeBets()
    func dealCards()
    func dealerBlackjackTest()
    func showDealerHasBlackjack()
    func selectPlayer()
    func calculateResult()
    func selectHand(cardIndex: Int, previousHand: Hand?, currentHand: Hand?)
    func playerGetChoice()
    func dealerGetChoice()
    func hitPlayer()
    func playerDoubleDown()
    func enableSplit()
    func showSplittedHand()
    func splitHand()
    func hitDealer()
    func distributeBets()
    func dealerStart()
    func noMoreMoney()
}
