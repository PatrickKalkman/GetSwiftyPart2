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
    
    var SelectedQuantity : String
    var SelectedQuantityIndex : Int
    
    var SelectedSourceUnit : String
    var SelectedSourceUnitIndex : Int
    
    var SelectedDestinationUnit : String
    var SelectedDestinationUnitIndex : Int
    
    init() {
        SelectedQuantityIndex = 0
        SelectedQuantity = ""
        
        SelectedSourceUnitIndex = 0
        SelectedSourceUnit = ""
        
        SelectedDestinationUnitIndex = 0
        SelectedDestinationUnit = ""
        
        buildConversions()
    }
    
    func setDefault() {
        SelectedQuantityIndex = 0
        SelectedQuantity = getQuantities()[0]
        
        SelectedSourceUnitIndex = 0
        SelectedSourceUnit = getUnits(quantity: SelectedQuantity)[0]
        
        SelectedDestinationUnitIndex = 0
        SelectedDestinationUnit = getUnits(quantity: SelectedQuantity)[0]
    }
    
    func setDefault(selectedQuantity: String) {
        SelectedSourceUnitIndex = 0
        SelectedSourceUnit = getUnits(quantity: selectedQuantity)[0]
        
        SelectedDestinationUnitIndex = 0
        SelectedDestinationUnit = getUnits(quantity: selectedQuantity)[0]
    }
    
    func getQuantities() -> [String]  {
        return conversionMatrix.keys.map({(key) -> String in return key})
    }
    
    func getUnits(quantity: String) -> [String] {
        
        guard let conversion : QuantityConversion = conversionMatrix[quantity] else {
            return [String]()
        }
        
        var result = conversion.conversions.map({(item) -> String in return item.sourceUnit})
        
        result.append(contentsOf: conversion.conversions.map({(item) -> String in return item.destinationUnit}))
        
        removeDuplicates(&result)
        
        return result
    }
    
    func removeDuplicates(_ strings: inout [String]) {
        strings = Set(strings).sorted()
    }
    
    func Convert(quantity: String, sourceUnit: String, destinationUnit: String, input: Double) -> Double {
        guard let quantityConversionMatrix : QuantityConversion = conversionMatrix[quantity] else {
            print("Cannot find quantity conversion matrix for \(quantity)")
            return 0
        }
        
        return quantityConversionMatrix.Convert(sourceUnit: sourceUnit, destinationUnit: destinationUnit, input: input)
    }
    
    func buildConversions() {
        buildTemperatureConversionMatrix()
        buildWeightConversionMatrix()
        buildLengthConversionMatrix()
        buildVolumeConversionMatrix()
    }
    
    func buildVolumeConversionMatrix() {
        let volume : QuantityConversion = QuantityConversion(quantity: "Volume")
        
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tablespoon", destinationUnit: "Teaspoon", conversionFactor: 3 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Cups", destinationUnit: "Teaspoon", conversionFactor: 48 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Teaspoon", conversionFactor: 192 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Teaspoon", conversionFactor:  639.494 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Teaspoon", destinationUnit: "Milliliters", conversionFactor:  5.919 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Deciliters", destinationUnit: "Teaspoon", conversionFactor: 20 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Liters", destinationUnit: "Teaspoon", conversionFactor: 168.936 ))
    
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Cups", destinationUnit: "Tablespoon", conversionFactor: 16 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Tablespoon", conversionFactor: 64 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Tablespoon", conversionFactor: 213.165 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tablespoon", destinationUnit: "Milliliters", conversionFactor: 17.758 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Deciliters", destinationUnit: "Tablespoon", conversionFactor: 6.763 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Liters", destinationUnit: "Tablespoon", conversionFactor: 56.3121 ))

        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Cups", conversionFactor: 4 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Cups", conversionFactor: 13.323 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Cups", destinationUnit: "Milliliters", conversionFactor:  284.131 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Cups", destinationUnit: "Deciliters", conversionFactor: 2.841 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Liters", destinationUnit: "Cups", conversionFactor: 3.52 ))

        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Quarts", conversionFactor: 3.331 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Milliliters", conversionFactor:  3785.412 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Deciliters", conversionFactor: 11.3652 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Liters", conversionFactor: 1.13652 ))
        
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Milliliters", conversionFactor: 3785.41 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Deciliters", conversionFactor:  37.8541 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Liters", conversionFactor: 3.78541 ))

        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Deciliters", destinationUnit: "Milliliters", conversionFactor: 100 ))
        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Liters", destinationUnit: "Milliliters", conversionFactor:  1000 ))

        volume.addConversion(unitConversion: SimpleConversion(sourceUnit: "Liters", destinationUnit: "Deciliters", conversionFactor:  10))

        conversionMatrix.updateValue(volume, forKey: volume.quantity)
    }
    
    func buildLengthConversionMatrix() {
        let length : QuantityConversion = QuantityConversion(quantity: "Length")
        
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Feet", destinationUnit: "Inches", conversionFactor: 12.0 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Yards", destinationUnit: "Inches", conversionFactor: 16.0 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Inches", conversionFactor: 63360.0 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Inches", destinationUnit: "Millimeters", conversionFactor: 25.4 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Inches", destinationUnit: "Centimeters", conversionFactor: 2.54 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Inches", conversionFactor: 39.37 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Inches", conversionFactor: 39370.079 ))
        
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Yards", destinationUnit: "Feet", conversionFactor: 3 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Feet", conversionFactor: 5280 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Feet", destinationUnit: "Millimeters", conversionFactor: 304.8 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Feet", destinationUnit: "Centimeters", conversionFactor: 30.48 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Feet", conversionFactor: 3.281 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Feet", conversionFactor: 3280.84 ))
        
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Yards", destinationUnit: "Feet", conversionFactor: 3 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Feet", conversionFactor: 5280 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Feet", destinationUnit: "Millimeters", conversionFactor: 304.8 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Feet", destinationUnit: "Centimeters", conversionFactor: 30.48 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Feet", conversionFactor: 3.281 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Feet", conversionFactor: 3280.84 ))
        
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Yards", conversionFactor: 1760 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Yards", destinationUnit: "Millimeters", conversionFactor: 914.4 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Yards", destinationUnit: "Centimeters", conversionFactor: 91.44 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Yards", conversionFactor: 1.094 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Yards", conversionFactor: 1093.613 ))
        
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Millimeters", conversionFactor: 1609344 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Centimeters", conversionFactor: 160934.4 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Meters", conversionFactor: 1609.344 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Kilometers", conversionFactor: 1.60934 ))
        
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Centimeters", destinationUnit: "Millimeters", conversionFactor: 10 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Millimeters", conversionFactor: 1000 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Millimeters", conversionFactor: 1000000 ))
        
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Centimeters", conversionFactor: 100 ))
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Centimeters", conversionFactor: 100000 ))
        
        length.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Meters", conversionFactor: 1000 ))
        
        conversionMatrix.updateValue(length, forKey: length.quantity)
    }
    
    func buildWeightConversionMatrix() {
        let weight : QuantityConversion = QuantityConversion(quantity: "Weight")
        
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Pounds", destinationUnit: "Ounces", conversionFactor: 16 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Stones", destinationUnit: "Pounds", conversionFactor: 14 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Pounds", destinationUnit: "Milligrams", conversionFactor: 453592.37 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Pounds", destinationUnit: "Grams", conversionFactor: 453.592 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilograms", destinationUnit: "Pounds", conversionFactor: 2.205 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Pounds", conversionFactor: 2240 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Stones", destinationUnit: "Ounces", conversionFactor: 224 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Ounces", destinationUnit: "Milligrams", conversionFactor: 28349.523 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Ounces", destinationUnit: "Grams", conversionFactor: 28.35 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilograms", destinationUnit: "Ounces", conversionFactor: 35.274) )
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Ounces", conversionFactor: 35840))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Stones", destinationUnit: "Milligrams", conversionFactor: 6350293.18 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Stones", destinationUnit: "Grams", conversionFactor: 6350.293 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Stones", destinationUnit: "Kilograms", conversionFactor: 6.35 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Stones", conversionFactor: 160))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Grams", destinationUnit: "Milligrams", conversionFactor: 1000 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilograms", destinationUnit: "Milligrams", conversionFactor: 1000000 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Milligrams", conversionFactor: 1016000000 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilograms", destinationUnit: "Grams", conversionFactor: 1000 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Grams", conversionFactor: 1016000 ))
        weight.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Kilograms", conversionFactor: 1016.047 ))
                
        conversionMatrix.updateValue(weight, forKey: weight.quantity)
    }
    
    func buildTemperatureConversionMatrix() {
        
        let temperature : QuantityConversion = QuantityConversion(quantity: "Temperature")
        
        temperature.addConversion(unitConversion: ComplexConversion(
            sourceUnit: "Celcius", destinationUnit: "Fahrenheit",
            conversionFunctionSourceDestination: {(input:Double) -> Double in return (input * (9.0 / 5.0)) + 32 },
            conversionFunctionDestinationSource: {(input:Double) -> Double in return (input - 32) * 5.0 / 9.0 }))
        
        temperature.addConversion(unitConversion: ComplexConversion(
            sourceUnit: "Celcius", destinationUnit: "Kelvin",
            conversionFunctionSourceDestination: {(input:Double) -> Double in return input + 273.15 },
            conversionFunctionDestinationSource: {(input:Double) -> Double in return input - 273.15 } ))
 
        temperature.addConversion(unitConversion: ComplexConversion(
            sourceUnit: "Fahrenheit", destinationUnit: "Kelvin",
            conversionFunctionSourceDestination: {(input:Double) -> Double in return ((input - 32) * 5.0 / 9.0) + 273.15 },
            conversionFunctionDestinationSource: {(input:Double) -> Double in return ((input - 273.15) * 9.0 / 5.0) + 32 }))

        conversionMatrix.updateValue(temperature, forKey: temperature.quantity)
    }
}
