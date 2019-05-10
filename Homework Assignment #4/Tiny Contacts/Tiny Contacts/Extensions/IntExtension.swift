//
//  IntExtension.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 10/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

extension Int {
    func random() -> Int {
        let isNegative = self < 0
        let random = Int(arc4random_uniform(UInt32(abs(self)))) * (isNegative ? -1 : 1)
        return random
    }
}
