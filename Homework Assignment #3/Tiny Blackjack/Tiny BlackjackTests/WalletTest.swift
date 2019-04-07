//
//  WalletTest.swift
//  Tiny BlackjackTests
//
//  Created by Patrick Kalkman on 07/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

import XCTest
@testable import Tiny_Blackjack

class WalletTest: XCTestCase {
    
    func test_add_ChipRed() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.DarkBlue)
        XCTAssertEqual(wallet.totalValue(), 100)
    }
    
}

class Wallet {
    
    var chips: [Chip] = [Chip]()
    
    func add(_ chip: Chip) {
        chips.append(chip)
    }
    
    func totalValue() -> UInt8 {
        return chips.reduce(0) { $0 + $1.rawValue }
    }
    
}

enum Chip: UInt8 {
    case LightRed = 1
    case Pink = 5
    case LightBlue = 10
    case Purple = 25
    case DarkRed = 50
    case DarkBlue = 100
}
