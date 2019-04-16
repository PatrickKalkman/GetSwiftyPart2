//
//  SimpleStrategy.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 24/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class SimpleStrategy: BlackjackStrategyProtocol {

    func calculateProposedAction(ownHand: Hand, otherHand: Hand) -> ProposedAction {

        if ownHand.count == 2 && ownHand.highValue() == 21 {
            return ProposedAction.blackjack
        }

        if ownHand.getValue() == 21 {
            return ProposedAction.stand
        }

        if shouldDoubleDown(ownHand, otherHand) {
            return ProposedAction.doubleOrHit
        }

        if shouldSplit(ownHand, otherHand) {
            return ProposedAction.split
        }

        if shouldStand(ownHand, otherHand) {
            return ProposedAction.stand
        }

        if shouldStandWithAce(ownHand, otherHand) {
            return ProposedAction.stand
        }

        return ProposedAction.hit
    }

    func shouldSplit(_ ownHand: Hand, _ otherHand: Hand) -> Bool {
//        4) Wanneer splits je?
//        4-4, 5-5, 10-10: nooit splitsen
//        8-8, Aas-Aas: altijd splitsen
//        2-2, 3-3, 6-6, 7-7, 9-9: alleen splitsen als de bank 2 t/m 6 heeft

        if ownHand.count != 2 {
            return false
        }

        if ownHand.containsOnly(Rank.ace) || ownHand.containsOnly(Rank.eight) {
            return true
        }

        if ownHand.containsOnly(Rank.four) || ownHand.containsOnly(Rank.five) || ownHand.containsOnly(Rank.ten) {
            return false
        }

        if ownHand.containsSameRank() {
            if otherHand.getValue() <= 6 {
                return true
            }
        }

        return false
    }

    func shouldStandWithAce(_ ownHand: Hand, _ otherHand: Hand) -> Bool {
//        2) Wanneer pas je met een Aas?
//        Heb je een Aas in je kaarten die je voor 1 of 11 punten kan tellen
//       (een ‘zachte’ hand), dan pas je iets minder snel:
//
//        Bank 2 t/m 6: passen bij 18 punten of hoger
//        Bank 7 t/m A: passen bij 19 of punten hoger

        let ownValue: UInt8 = ownHand.getValue()
        if ownHand.isSoft() {
            let otherValue: UInt8 = otherHand.getValue()

            if otherValue <= 6 {
                if ownValue >= 18 {
                    return true
                }
            }

            if otherValue <= 11 {
                if ownValue >= 19 {
                    return true
                }
            }
        }
        return false
    }

    func shouldStand(_ ownHand: Hand, _ otherHand: Hand) -> Bool {

//        1) Wanneer pas je?
//        Bank 2 t/m 6: je past bij 12 punten of hoger
//        Bank 7 t/m A: je past bij 17 punten of hoger

        if ownHand.isHard() {
            let otherValue: UInt8 = otherHand.getValue()
            let ownValue: UInt8 = ownHand.getValue()

            if otherValue <= 6 {
                if ownValue >= 12 {
                    return true
                }
            }

            if otherValue <= 11 {
                if ownValue >= 17 {
                    return true
                }
            }
        }

        return false
    }

    func shouldDoubleDown(_ ownHand: Hand, _ otherHand: Hand) -> Bool {
//        3) Wanneer dubbel je?
//        Met 9 punten: als de bank een 2 t/m 6 heeft
//        Met 10 of 11 punten: als de bank 2 t/m 9 heeft

        // Can only double down after first deal of cards
        if ownHand.count == 2 {
            let otherValue: UInt8 = otherHand.getValue()
            let ownValue: UInt8 = ownHand.getValue()

            if ownValue == 9 {
                if otherValue >= 2 && otherValue <= 6 {
                    return true
                }
            }

            if ownValue == 10 || ownValue == 11 {
                if otherValue >= 2 && otherValue <= 9 {
                    return true
                }
            }
        }

        return false
    }
}
