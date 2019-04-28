//
//  CardCountCalculator.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 26/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

// This class is responsible for calculating the running count,
// true count and the number of betting units
public class CardCountCalculator {
    
    private var remainingDecks: Int = 0
    private var cards: [Card] = [Card]()

    func start(remainingDecks: Int) {
        self.remainingDecks = remainingDecks
    }
    
    func addCards(card: Card) {
        cards.append(card)
    }
    
    func calculateRunningCount() -> Int {
        var runningCount: Int = 0
        for card in cards {
            runningCount += getHighLowValue(card)
        }
        return runningCount
    }
    
    func calculateTrueCount() -> Int {
        if remainingDecks == 0 {
            return 0
        }

        let numberOfDecksRemaining: Float = Float(remainingDecks * 52 - cards.count) / 52.0
        let numberOfDecksRemainingRounded: Int = Int(numberOfDecksRemaining.rounded(FloatingPointRoundingRule.down))
        
        if (numberOfDecksRemainingRounded > 0) {
            return calculateRunningCount() / numberOfDecksRemainingRounded
        } else {
            return calculateRunningCount()
        }
    }
    
    func getBettingUnits() -> UInt {
        let numberOfBettingUnits: Int = calculateTrueCount() - 1
        if numberOfBettingUnits < 0 {
            return 0
        } else {
            return UInt(numberOfBettingUnits)
        }
    }
    
    private func getHighLowValue(_ card: Card) -> Int {
        switch card.rank {
        case Rank.ace, Rank.ten, Rank.king, Rank.jack, Rank.queen:
            return -1
        case Rank.two, Rank.three, Rank.four, Rank.five, Rank.six:
            return 1
        case Rank.seven, Rank.eight, Rank.nine:
            return 0
        }
    }
    
}
