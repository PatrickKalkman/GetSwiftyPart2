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
        wallet.add(Chip.DarkBlue)
        XCTAssertEqual(wallet.totalValue(), 100)
    }
    
    func test_add_two_chips() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.DarkBlue)
        wallet.add(Chip.LightRed)
        XCTAssertEqual(wallet.totalValue(), 101)
    }
    
    func test_remove_chip() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.DarkBlue)
        wallet.remove(Chip.DarkBlue)
        XCTAssertEqual(wallet.totalValue(), 0)
    }
    
    func test_hasChip_whenChipExists() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.DarkBlue)
        XCTAssertTrue(wallet.hasChip(Chip.DarkBlue))
    }
    
    func test_hasChip_whenChipDoesNotExists() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.DarkBlue)
        XCTAssertFalse(wallet.hasChip(Chip.DarkRed))
    }
    
    func test_clear_removesAllFromWallet() {
        let wallet: Wallet = Wallet()
        wallet.add(Chip.DarkBlue)
        wallet.add(Chip.LightRed)
        wallet.clear()
        XCTAssertEqual(wallet.totalValue(), 0)
    }
    
    func test_canAddMultipleChipsAtOnce() {
        
        var chips: [Chip] = [Chip]()
        chips.append(Chip.DarkRed)
        chips.append(Chip.LightBlue)
        
        let wallet: Wallet = Wallet()
        wallet.add(chips)

        XCTAssertTrue(wallet.hasChip(Chip.DarkRed))
    }
}
