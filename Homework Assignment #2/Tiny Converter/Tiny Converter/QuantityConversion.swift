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
    var conversions: [SimpleConversion] = []
    
    init(quantity: String) {
        self.quantity = quantity
    }
    
    func addConversion(unitConversion: SimpleConversion) {
        self.conversions.append(unitConversion)
    }
    
    func Convert(sourceUnit: String, destinationUnit: String, input: Double) -> Double {
        
        if (sourceUnit == destinationUnit) {
            return input
        }
        
        for conversion in conversions {
            if conversion.sourceUnit == sourceUnit && conversion.destinationUnit == destinationUnit {
                return calculateConversionSourceDestination(conversion: conversion, input: input)
            } else if  conversion.sourceUnit == destinationUnit && conversion.destinationUnit == sourceUnit {
                return calculateConversionDestinationSource(conversion: conversion, input: input)
            }
        }
        
        print("Conversion for \(self.quantity) from \(sourceUnit) to \(destinationUnit) not found")
        return 0
    }
    
    func calculateConversionSourceDestination(conversion: SimpleConversion, input: Double) -> Double {
        // Check if is a simple or complex conversion
        if let convertedConversion = conversion as? ComplexConversion {
            return convertedConversion.conversionFunctionSourceDestination(input)
        } else {
            if let factor = conversion.conversionFactor {
                return input * factor
            }
            print("Conversion was a simple conversion but contained no conversion factor")
            return 0
        }
    }
    
    func calculateConversionDestinationSource(conversion: SimpleConversion, input: Double) -> Double {
        // Check if is a simple or complex conversion
        if let convertedConversion = conversion as? ComplexConversion {
            return convertedConversion.conversionFunctionDestinationSource(input)
        } else {
            if let factor = conversion.conversionFactor {
                return input / factor
            }
            print("Conversion was a simple conversion but contained no conversion factor")
            return 0
        }
    }
}
