//
//  QuantityConversion.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 14/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class QuantityConversion {
    var quantity: String
    var conversions: [UnitConversion] = []
    
    init(quantity: String) {
        self.quantity = quantity
    }
    
    func addConversion(unitConversion: UnitConversion) {
        self.conversions.append(unitConversion)
    }
    
    func Convert(sourceUnit: String, destinationUnit: String, input: Double) -> Double {
        
        if (sourceUnit == destinationUnit) {
            return input
        }
        
        for conversion in conversions {
            if conversion.sourceUnit == sourceUnit && conversion.destinationUnit == destinationUnit {
                return conversion.conversionFunctionSourceDestination(input)
            } else if  conversion.sourceUnit == destinationUnit && conversion.destinationUnit == sourceUnit {
                return conversion.conversionFunctionDestinationSource(input)
            }
        }
        
        print("Conversion for \(self.quantity) from \(sourceUnit) to \(destinationUnit) not found")
        return 0
    }
}
