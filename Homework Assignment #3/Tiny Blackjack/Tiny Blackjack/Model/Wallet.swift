//
//  Wallet.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 07/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class Wallet {

    var chips: [Chip] = [Chip]()

    func add(_ chip: Chip) {
        chips.append(chip)
    }

    func add(_ chipsToAdd: [Chip]) {
        chips.append(contentsOf: chipsToAdd)
    }

    func remove(_ chipToRemove: Chip) {

        var currentChipIndex: Int = 0
        var chipToRemoveIndex: Int?
        for chip in chips {
            if chip == chipToRemove {
                chipToRemoveIndex = currentChipIndex
            }
            currentChipIndex += 1
        }

        if let chipIndex = chipToRemoveIndex {
            chips.remove(at: chipIndex)
        }
    }

    func hasChip(_ chipType: Chip) -> Bool {
        return chips.contains(chipType)
    }

    func isLastChip(_ chip: Chip) -> Bool {
        let filteredChips: [Chip] = chips.filter { $0 == chip }
        return filteredChips.count == 1
    }

    func totalValue() -> UInt {
        return chips.reduce(0) { $0 + $1.rawValue }
    }

    func getAll() -> [Chip] {
        return chips
    }

    func clear() {
        chips.removeAll()
    }
}
