//
//  InitialChipsGenerator.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 09/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class InitialChipsGenerator {
    
    func generateInitialChips() -> [Chip] {
        var chips: [Chip] = [Chip]()
        
        for _ in 1...5 {
            chips.append(Chip.DarkBlue) // 500
        }
        
        for _ in 1...5 {
            chips.append(Chip.DarkRed) // 250
        }
        
        for _ in 1...10 {
            chips.append(Chip.Purple) // 250
        }
        
        for _ in 1...14 {
            chips.append(Chip.LightBlue) // 250
        }
        
        for _ in 1...10 {
            chips.append(Chip.Pink) // 250
        }
        
        for _ in 1...10 {
            chips.append(Chip.LightRed) // 250
        }
        
        return chips
    }
    
}
