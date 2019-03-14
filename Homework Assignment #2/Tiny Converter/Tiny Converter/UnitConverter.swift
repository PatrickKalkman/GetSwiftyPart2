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
        
    }
    
    func buildWeightConversionMatrix() {
        let weight : QuantityConversion = QuantityConversion(quantity: "Weight")
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Pounds", destinationUnit: "Ounces",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input * 16 },
            conversionFunctionDestinationSource: {(input: Double) -> Double in return input / 16 }))
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Pounds", destinationUnit: "Stones",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input / 14 },
            conversionFunctionDestinationSource: {(input: Double) -> Double in return input * 14 }))
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Pounds", destinationUnit: "Milligrams",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input * 453592.37 },
            conversionFunctionDestinationSource: {(input: Double) -> Double in return input / 453592.37 }))
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Pounds", destinationUnit: "Grams",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input * 453.592 },
            conversionFunctionDestinationSource: {(input: Double) -> Double in return input / 453.592 }))
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Pounds", destinationUnit: "Kilograms",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input / 2.205 },
            conversionFunctionDestinationSource: {(input: Double) -> Double in return input * 2.205 }))
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Pounds", destinationUnit: "Tons",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input / 2204.623 },
            conversionFunctionDestinationSource:  {(input: Double) -> Double in return input / 2204.623 } ))

        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Ounces", destinationUnit: "Stones",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input / 224 },
            conversionFunctionDestinationSource:  {(input: Double) -> Double in return input * 224 } ))
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Ounces", destinationUnit: "Milligrams",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input * 28349.523 },
            conversionFunctionDestinationSource:  {(input: Double) -> Double in return input / 28349.523 } ))
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Ounces", destinationUnit: "Grams",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input * 28.35 },
            conversionFunctionDestinationSource:  {(input: Double) -> Double in return input / 28.35 } ))
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Ounces", destinationUnit: "Kilograms",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input / 35.274 },
            conversionFunctionDestinationSource:  {(input: Double) -> Double in return input * 35.274 } ))
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Ounces", destinationUnit: "Tons",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input / 35840 },
            conversionFunctionDestinationSource:  {(input: Double) -> Double in return input * 35840 } ))
        
        weight.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Stones", destinationUnit: "Milligrams",
            conversionFunctionSourceDestination: {(input: Double) -> Double in return input * (6.35029318 * 1000000) },
            conversionFunctionDestinationSource:  {(input: Double) -> Double in return input / (6.35029318 * 1000000)} ))
        
        conversionMatrix.updateValue(weight, forKey: weight.quantity)
        
//        Pounds
//        Ounces
//        Stone
//        Milligrams
//        Grams
//        Kilograms
//        Tons

    }
    
    func buildTemperatureConversionMatrix() {
        
        let temperature : QuantityConversion = QuantityConversion(quantity: "Temperature")
        
        temperature.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Celcius", destinationUnit: "Fahrenheit",
            conversionFunctionSourceDestination: {(input:Double) -> Double in return (input * (9.0 / 5.0)) + 32 },
            conversionFunctionDestinationSource: {(input:Double) -> Double in return (input - 32) * 5.0 / 9.0 }))
        
        temperature.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Celcius", destinationUnit: "Kelvin",
            conversionFunctionSourceDestination: {(input:Double) -> Double in return input + 273.15 },
            conversionFunctionDestinationSource: {(input:Double) -> Double in return input - 273.15 } ))
 
        temperature.addConversion(unitConversion: UnitConversion(
            sourceUnit: "Fahrenheit", destinationUnit: "Kelvin",
            conversionFunctionSourceDestination: {(input:Double) -> Double in return ((input - 32) * 5.0 / 9.0) + 273.15 },
            conversionFunctionDestinationSource: {(input:Double) -> Double in return ((input - 273.15) * 9.0 / 5.0) + 32 }))

        conversionMatrix.updateValue(temperature, forKey: temperature.quantity)
    }

}
