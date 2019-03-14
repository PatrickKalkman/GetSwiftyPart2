//
//  UnitConversion.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 14/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class UnitConversion {
    var sourceUnit: String
    var destinationUnit: String
    var conversionFunctionSourceDestination: ((Double) -> (Double))
    var conversionFunctionDestinationSource: ((Double) -> (Double))
    
    init(sourceUnit: String,
         destinationUnit: String,
         conversionFunctionSourceDestination: @escaping ((Double) -> (Double)),
         conversionFunctionDestinationSource: @escaping ((Double) -> (Double))) {
        self.sourceUnit = sourceUnit
        self.destinationUnit = destinationUnit
        self.conversionFunctionSourceDestination = conversionFunctionSourceDestination
        self.conversionFunctionDestinationSource = conversionFunctionDestinationSource
    }
}
