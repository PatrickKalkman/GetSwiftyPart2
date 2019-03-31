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
    func selectPlayer()
    func calculateResult()
    func selectHand()
    func playerGetChoice()
    func dealerGetChoice()
    func hitPlayer()
    func playerDoubleDown()
    func splitHand()
    func hitDealer()
    func distributeBets()
}
