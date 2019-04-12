//
//  InitialChipsGenerator.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 09/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

// This class is responsible for generating the initial chips of a player, currently 1200$
class InitialChipsGenerator {

    func generateInitialChips() -> [Chip] {
        var chips: [Chip] = [Chip]()

        for _ in 1...5 {
            chips.append(Chip.darkBlue) // 500
        }

        for _ in 1...5 {
            chips.append(Chip.darkRed) // 250
        }

        for _ in 1...10 {
            chips.append(Chip.purple) // 250
        }

        for _ in 1...14 {
            chips.append(Chip.lightBlue) // 250
        }

        for _ in 1...10 {
            chips.append(Chip.pink) // 250
        }

        for _ in 1...10 {
            chips.append(Chip.lightRed) // 250
        }

        return chips
    }

}
