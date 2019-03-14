//
//  UnitConverter.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 14/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class UnitConverter {
    
    var conversionMatrix: Dictionary<String, QuantityConversion> = [:]
    
    let Quantities : [String] = ["Weight", "Volume", "Length", "Temperature"]
    
    let Units : [String] = ["Inches", "Feets", "Yards", "Miles", "Millimeters", "Centimeters", "Meters", "Kilometers"]
    
    var SelectedQuantity : String
    var SelectedQuantityIndex : Int
    
    var SelectedSourceUnit : String
    var SelectedSourceUnitIndex : Int
    
    var SelectedDestinationUnit : String
    var SelectedDestinationUnitIndex : Int
    
    init() {
        SelectedQuantityIndex = 2
        SelectedQuantity = Quantities[SelectedQuantityIndex]
        
        SelectedSourceUnitIndex = 0
        SelectedSourceUnit = Units[SelectedSourceUnitIndex]
        
        SelectedDestinationUnitIndex = 5
        SelectedDestinationUnit = Units[SelectedDestinationUnitIndex]
        
        buildConversionMatrix()
    }
    
    func Convert(quantity: String, sourceUnit: String, destinationUnit: String, input: Double) -> Double {
        guard let quantityConversionMatrix : QuantityConversion = conversionMatrix[quantity] else {
            print("Cannot find quantity conversion matrix for \(quantity)")
            return 0
        }
        
        return quantityConversionMatrix.Convert(sourceUnit: sourceUnit, destinationUnit: destinationUnit, input: input)
    }
    
    
    func buildConversionMatrix() {
        
        let temperature : QuantityConversion = QuantityConversion(quantity: "Temperature")
        
        temperature.addConversion(unitConversion: UnitConversion(sourceUnit: "Celcius", destinationUnit: "Fahrenheit", conversionFunction: {(celcius:Double) -> Double in return (celcius * 9.0 / 5.0) + 10.5 } ))
      
        temperature.addConversion(unitConversion: UnitConversion(sourceUnit: "Fahrenheit", destinationUnit: "Celcius", conversionFunction: {(fahrenheit:Double) -> Double in return (fahrenheit - 32) * 5.0 / 9.0 } ))
        
        //(2323°F − 32) × 5/9
        
        conversionMatrix.updateValue(temperature, forKey: temperature.quantity)
        
    }
    
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
            for conversion in conversions {
                if conversion.sourceUnit == sourceUnit && conversion.destinationUnit == destinationUnit {
                    return conversion.conversionFunction(input)
                }
            }
            Print("Conversion for \(self.quantity) from \(sourceUnit) to \(destinationUnit) not found")
        }
    }
    
    class UnitConversion {
        var sourceUnit: String
        var destinationUnit: String
        var conversionFunction: ((Double) -> (Double))
        
        init(sourceUnit: String, destinationUnit: String, conversionFunction: @escaping ((Double) -> (Double))) {
            self.sourceUnit = sourceUnit
            self.destinationUnit = destinationUnit
            self.conversionFunction = conversionFunction
        }
    }
}
