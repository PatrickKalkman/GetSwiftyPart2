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
    
    func test_emptyWallet_returns_totalValue_0() {
        let wallet: Wallet = Wallet()
        XCTAssertEqual(wallet.totalValue(), 0)
    }
    
    func test_add_chipDarkBlue() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.darkBlue)
        XCTAssertEqual(wallet.totalValue(), 100)
    }
    
    func test_add_two_chips() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.darkBlue)
        wallet.add(Chip.lightRed)
        XCTAssertEqual(wallet.totalValue(), 101)
    }
    
    func test_remove_chip() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.darkBlue)
        wallet.remove(Chip.darkBlue)
        XCTAssertEqual(wallet.totalValue(), 0)
    }
    
    func test_hasChip_whenChipExists() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.darkBlue)
        XCTAssertTrue(wallet.hasChip(Chip.darkBlue))
    }
    
    func test_hasChip_whenChipDoesNotExists() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.darkBlue)
        XCTAssertFalse(wallet.hasChip(Chip.darkRed))
    }
    
    func test_clear_removesAllFromWallet() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.darkBlue)
        wallet.add(Chip.lightRed)
        wallet.clear()
        XCTAssertEqual(wallet.totalValue(), 0)
    }
    
    func test_canAddMultipleChipsAtOnce() {
        
        var chips: [Chip] = [Chip]()
        chips.append(Chip.darkRed)
        chips.append(Chip.lightBlue)
        
        let wallet: Wallet = Wallet()
        wallet.add(chips)

        XCTAssertTrue(wallet.hasChip(Chip.darkRed))
    }
}
