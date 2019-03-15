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
        var result = conversionMatrix.keys.map({(key) -> String in return key})
        removeDuplicates(&result)
        return result
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
        buildAreaConversionMatrix()
        buildPowerConversionMatrix()
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
    
    func buildPowerConversionMatrix() {
        let power : QuantityConversion = QuantityConversion(quantity: "Power")
        
        power.addConversion(unitConversion: SimpleConversion(sourceUnit: "Horse Power", destinationUnit: "btu/h", conversionFactor: 2544.43 ))
        power.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilowatt", destinationUnit: "btu/h", conversionFactor: 3412.14 ))
        power.addConversion(unitConversion: SimpleConversion(sourceUnit: "Watt", destinationUnit: "btu/h", conversionFactor: 3.4121))
        power.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tonne of refr.", destinationUnit: "btu/h", conversionFactor: 12000))
        
        power.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilowatt", destinationUnit: "Horse Power", conversionFactor: 1.3596 ))
        power.addConversion(unitConversion: SimpleConversion(sourceUnit: "Horse Power", destinationUnit: "Watt", conversionFactor: 735.50))
        power.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tonne of refr.", destinationUnit: "Horse Power", conversionFactor: 4.7816))
        
        power.addConversion(unitConversion: SimpleConversion(sourceUnit: "Kilowatt", destinationUnit: "Watt", conversionFactor: 1000 ))
        power.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tonne of refr.", destinationUnit: "Kilowatt", conversionFactor: 3.5169))

        power.addConversion(unitConversion: SimpleConversion(sourceUnit: "Tonne of refr.", destinationUnit: "Watt", conversionFactor: 3516.8528))
        
        conversionMatrix.updateValue(power, forKey: power.quantity)
    }
    
    func buildAreaConversionMatrix() {
        let area : QuantityConversion = QuantityConversion(quantity: "Area")
        
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Are", conversionFactor: 40.5 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Are", conversionFactor: 2.5 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Centimeter", conversionFactor: 40468564.2 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Decimeter", conversionFactor: 404685.6 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Foot", conversionFactor: 43560 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Acre", conversionFactor: 2.5 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Inch", conversionFactor: 6272640 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Acre", conversionFactor: 247.1 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Meter", conversionFactor: 4046.9 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Micrometer", conversionFactor: 4046856422000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Acre", conversionFactor: 640 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Millimeter", conversionFactor: 4046856422 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Nanometer", conversionFactor: 4046856421999999713280 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Yard", conversionFactor: 4840 ))

        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Are", conversionFactor: 100 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Centimeter", conversionFactor: 1000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Decimeter", conversionFactor: 10000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Foot", conversionFactor: 1076.4 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Are", conversionFactor: 2.5 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Inch", conversionFactor: 1550003 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Are", conversionFactor: 10000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Meter", conversionFactor: 100 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Micrometer", conversionFactor: 100000000000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Are", conversionFactor: 25899.9 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Millimeter", conversionFactor: 100000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Nanometer", conversionFactor: 100000000000000000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Yard", conversionFactor: 119.6 ))
        
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Centimeter", conversionFactor: 100000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Decimeter", conversionFactor: 1000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Foot", conversionFactor: 107639.1 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Hectare", conversionFactor: 1 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Inch", conversionFactor: 15500031 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Hectare", conversionFactor: 100 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Meter", conversionFactor: 10000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Micrometer", conversionFactor: 10000000000000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Hectare", conversionFactor: 259 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Millimeter", conversionFactor: 10000000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Nanometer", conversionFactor: 10000000000000000000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Yard", conversionFactor: 11959.9 ))
        
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Decimeter", destinationUnit: "Sq Centimeter", conversionFactor: 100 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Centimeter", conversionFactor: 929 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Centimeter", conversionFactor: 100000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Inch", destinationUnit: "Sq Centimeter", conversionFactor: 6.5 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Centimeter", conversionFactor: 10000000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Centimeter", conversionFactor: 100000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Centimer", destinationUnit: "Sq Micrometer", conversionFactor: 100000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Centimer", conversionFactor: 25899881100 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Centimer", destinationUnit: "Sq Millimeter", conversionFactor: 100))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Centimer", destinationUnit: "Sq Nanometer", conversionFactor: 100000000000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Centimer", conversionFactor: 8361.3 ))
        
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Decimeter", conversionFactor: 9.3 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Decimeter", conversionFactor: 1000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Decimeter", destinationUnit: "Sq Inch", conversionFactor: 15.5 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Decimeter", conversionFactor: 100000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Decimeter", conversionFactor: 100 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Decimeter", destinationUnit: "Sq Micrometer", conversionFactor: 10000000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Decimeter", conversionFactor: 258998811 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Decimeter", destinationUnit: "Sq Millimeter", conversionFactor: 10000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Decimeter", destinationUnit: "Sq Nanometer", conversionFactor: 10000000000000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Decimeter", conversionFactor: 83.613 ))

        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Foot", conversionFactor: 107639.1 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Inch", conversionFactor: 144 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Foot", conversionFactor: 10763910.4 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Foot", conversionFactor: 10.8 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Micrometer", conversionFactor: 92903040000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Foot", conversionFactor: 27878400 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Millimeter", conversionFactor: 92903))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Nanometer", conversionFactor: 92903040000000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Foot", conversionFactor: 9 ))

        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Inch", conversionFactor: 15500031 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Hectometer", conversionFactor: 100 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Meter", conversionFactor: 10000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Micrometer", conversionFactor: 10000000000000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Hectometer", conversionFactor: 259 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Millimeter", conversionFactor: 10000000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Nanometer", conversionFactor: 10000000000000000000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Yard", conversionFactor: 11959.9 ))

        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Inch", conversionFactor: 1550003100 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Inch", conversionFactor: 1550 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Inch", destinationUnit: "Sq Micrometer", conversionFactor: 645160000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Inch", conversionFactor: 4014489599.5 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Inch", destinationUnit: "Sq Millimeter", conversionFactor: 645.2))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Inch", destinationUnit: "Sq Nanometer", conversionFactor: 6451599999999999))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Inch", conversionFactor: 1296 ))

        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Meter", conversionFactor: 1000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Micrometer", conversionFactor: 1000000000000000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Kilometer", conversionFactor: 2.6 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Millimeter", conversionFactor: 1000000000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Nanometer", conversionFactor: 999999999999999983222784))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Yard", conversionFactor: 1195990 ))

        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Micrometer", conversionFactor: 1000000000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Meter", conversionFactor: 2589988.1 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Millimeter", conversionFactor: 1000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Nanometer", conversionFactor: 999999999999999872))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Yard", conversionFactor: 1.2 ))
        
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Micrometer", conversionFactor: 2589988110000000000 ))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Millimeter", destinationUnit: "Sq Micrometer", conversionFactor: 1000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Micrometer", destinationUnit: "Sq Nanometer", conversionFactor: 1000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Micrometer", conversionFactor: 836127360000 ))

        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Millimeter", conversionFactor: 2589988110000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Nanometer", conversionFactor: 2589988109999999809486848))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Yard", conversionFactor: 3097600 ))

        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Millimeter", destinationUnit: "Sq Nanometer", conversionFactor: 1000000000000))
        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Millimeter", conversionFactor: 836127.4 ))

        area.addConversion(unitConversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Nanometer", conversionFactor: 836127359999999872 ))

        conversionMatrix.updateValue(area, forKey: area.quantity)
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
