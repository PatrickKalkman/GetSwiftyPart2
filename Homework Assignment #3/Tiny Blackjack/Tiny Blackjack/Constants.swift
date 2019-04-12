//
//  Constants.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 08/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

// Defines global constants for the application
struct Constants {

    struct Animation {
        static let FlipCardDuration: Double = 0.3
        static let DealCardDuraction: Double = 0.7
        static let SplitMoveCardDuration: Double = 0.4
        static let PlaceBetDuraction: Double = 0.3
    }

    struct Positions {
        static let FirstCardX: CGFloat = 400
        static let CardXDifference: CGFloat = 40
        static let FirstCardY: CGFloat = 450
        static let FirstDealerCard: CGPoint = CGPoint(x: FirstCardX, y: 80)
        static let SecondDealerCard: CGPoint = CGPoint(x: 440, y: 80)
        static let FirstPlayerCard: CGPoint = CGPoint(x: FirstCardX, y: FirstCardY)
        static let SecondPlayerCard: CGPoint = CGPoint(x: FirstCardX + CardXDifference, y: FirstCardY)
        static let PlayerValueLabel: CGPoint = CGPoint(x: 450, y: FirstCardY - 50)
        static let DealerValueLabel: CGPoint = CGPoint(x: 450, y: 20)
    }

    struct Assets {
        static let FacedownCard: String = "Card.Facedown"
        static let AddChipSound: String = "AddChip"
        static let CardSound: String = "Card1"
        static let ShuffleSound: String = "Shuffle"
        static let SoundExtension: String = "wav"
    }

}
