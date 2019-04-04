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
        static let FlipCardDuration: Double = 0.4
        static let DealCardDuraction: Double = 0.8
    }

    struct Positions {
        static let FirstDealerCard: CGPoint = CGPoint(x: 400, y: 80)
        static let SecondDealerCard: CGPoint = CGPoint(x: 440, y: 80)
        static let FirstPlayerCard: CGPoint = CGPoint(x: 400, y: 500)
        static let SecondPlayerCard: CGPoint = CGPoint(x: 440, y: 500)
        static let PlayerValueLabel: CGPoint = CGPoint(x: 450, y: 450)
        static let DealerValueLabel: CGPoint = CGPoint(x: 450, y: 20)
    }

    struct Assets {
        static let FacedownCard: String = "Card.Facedown"
    }
}
