//
//  SimpleConversion.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 15/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class SimpleConversion {
    var sourceUnit: String
    var destinationUnit: String
    var conversionFactor: Double?
    
    init(sourceUnit: String,
         destinationUnit: String,
         conversionFactor: Double?) {
        self.sourceUnit = sourceUnit
        self.destinationUnit = destinationUnit
        self.conversionFactor = conversionFactor
    }
}
