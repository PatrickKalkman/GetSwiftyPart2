//
//  UnitConverter.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 14/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class UnitConverter {

    var conversionMatrix: [String: QuantityConversion] = [:]

    var selectedQuantity: String = ""
    var selectedQuantityIndex: Int = 0

    var selectedSourceUnit: String = ""
    var selectedSourceUnitIndex: Int = 0

    var selectedDestinationUnit: String = ""
    var selectedDestinationUnitIndex: Int = 0

    init() {
        buildConversions()
    }

    func setDefault() {
        selectedQuantityIndex = 3
        selectedQuantity = getQuantities()[3]

        selectedSourceUnitIndex = 0
        selectedSourceUnit = getUnits(quantity: selectedQuantity)[0]

        selectedDestinationUnitIndex = 1
        selectedDestinationUnit = getUnits(quantity: selectedQuantity)[1]
    }

    func setDefault(selectedQuantity: String) {
        selectedSourceUnitIndex = 0
        selectedSourceUnit = getUnits(quantity: selectedQuantity)[0]

        selectedDestinationUnitIndex = 0
        selectedDestinationUnit = getUnits(quantity: selectedQuantity)[0]
    }

    func getQuantities() -> [String] {
        var result = conversionMatrix.keys.map({ (key) -> String in return key })
        removeDuplicates(&result)
        return result
    }

    func getUnits(quantity: String) -> [String] {

        guard let conversion: QuantityConversion = conversionMatrix[quantity] else {
            return [String]()
        }

        var result = conversion.conversions.map({ (item) -> String in return item.sourceUnit })
        result.append(contentsOf: conversion.conversions.map({ (item) -> String in return item.destinationUnit }))
        removeDuplicates(&result)
        return result
    }

    func removeDuplicates(_ strings: inout [String]) {
        strings = Set(strings).sorted()
    }

    func convert(input: Double, direction: CalculationDirection) -> Double {
        guard let quantityConversionMatrix: QuantityConversion = conversionMatrix[selectedQuantity] else {
            print("Cannot find quantity conversion matrix for \(selectedQuantity)")
            return 0
        }

        if direction == CalculationDirection.sourceToDestination {
            return quantityConversionMatrix.convert(sourceUnit: selectedSourceUnit,
                destinationUnit: selectedDestinationUnit, input: input)
        } else {
            return quantityConversionMatrix.convert(sourceUnit: selectedDestinationUnit,
                destinationUnit: selectedSourceUnit, input: input)
        }
    }

    func buildConversions() {

        let weightConversion: QuantityConversion = WeightConversionBuilder.buildWeightConversionMatrix()
        conversionMatrix.updateValue(weightConversion, forKey: weightConversion.quantity)

        let lengthConversion: QuantityConversion = LengthConversionBuilder.buildLengthConversionMatrix()
        conversionMatrix.updateValue(lengthConversion, forKey: lengthConversion.quantity)

        let temperatureConversion: QuantityConversion = TemperatureConversionBuilder.buildTemperatureConversionMatrix()
        conversionMatrix.updateValue(temperatureConversion, forKey: temperatureConversion.quantity)

        let powerConversion: QuantityConversion = PowerConversionBuilder.buildPowerConversionMatrix()
        conversionMatrix.updateValue(powerConversion, forKey: powerConversion.quantity)

        let volumeConversion: QuantityConversion = VolumeConversionBuilder.buildVolumeConversionMatrix()
        conversionMatrix.updateValue(volumeConversion, forKey: volumeConversion.quantity)

        let areaConversion: QuantityConversion = AreaConversionBuilder.buildAreaConversionMatrix()
        conversionMatrix.updateValue(areaConversion, forKey: areaConversion.quantity)
    }
}
