//
//  CardToImageNameMapper.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 31/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

// This class is responsible for mapping a Card from the model to the name of
// an asset(image)
class CardToImageNameMapper {

    func map(_ card: Card) -> String {

        let suit: String = mapSuit(card.suit)
        let rank: String = mapRank(card.rank)

        return "\(suit).\(rank)"
    }

    func mapRank(_ rank: Rank) -> String {
        var rankString: String = ""

        switch rank {
        case Rank.ace:
            rankString = "Ace"
        case Rank.two:
            rankString = "2"
        case Rank.three:
            rankString = "3"
        case Rank.four:
            rankString = "4"
        case Rank.five:
            rankString = "5"
        case Rank.six:
            rankString = "6"
        case Rank.seven:
            rankString = "7"
        case Rank.eight:
            rankString = "8"
        case Rank.nine:
            rankString = "9"
        case Rank.ten:
            rankString = "10"
        case Rank.jack:
            rankString = "Jack"
        case Rank.king:
            rankString = "King"
        case Rank.queen:
            rankString = "Queen"
        }

        return rankString
    }

    func mapSuit(_ suit: Suit) -> String {
        var suitString: String = ""

        switch suit {
        case Suit.club:
            suitString = "Club"
        case Suit.diamond:
            suitString = "Diamond"
        case Suit.heart:
            suitString = "Heart"
        case Suit.spade:
            suitString = "Spade"
        }

        return suitString
    }

}
