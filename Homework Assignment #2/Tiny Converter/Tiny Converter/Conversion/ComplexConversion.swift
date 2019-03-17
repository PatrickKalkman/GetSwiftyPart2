//
//  UnitConversion.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 14/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

// This class defines a conversion between two units that need a specialized
// function. For example, the Celcius to Fahrenheit conversion
class ComplexConversion: SimpleConversion {

    var conversionFunctionSourceDestination: ((Double) -> (Double))
    var conversionFunctionDestinationSource: ((Double) -> (Double))

    init(sourceUnit: String,
         destinationUnit: String,
         conversionFunctionSourceDestination: @escaping ((Double) -> (Double)),
         conversionFunctionDestinationSource: @escaping ((Double) -> (Double))) {

        self.conversionFunctionSourceDestination = conversionFunctionSourceDestination
        self.conversionFunctionDestinationSource = conversionFunctionDestinationSource

        super.init(sourceUnit: sourceUnit, destinationUnit: destinationUnit, factor: nil)
    }
}
