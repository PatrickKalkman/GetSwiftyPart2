//
//  SimpleConversion.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 15/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

// This class defines a unit conversion in which case the unit can be converted
// using multiplying it by a factor
class SimpleConversion {
    var sourceUnit: String
    var destinationUnit: String
    var factor: Double?

    init(sourceUnit: String,
         destinationUnit: String,
         factor: Double?) {
        self.sourceUnit = sourceUnit
        self.destinationUnit = destinationUnit
        self.factor = factor
    }
}
