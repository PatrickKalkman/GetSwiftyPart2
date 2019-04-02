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
    func dealerStart()
}
