//
//  WeightConversionBuilder.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 17/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class WeightConversionBuilder {

    class func buildWeightConversionMatrix() -> QuantityConversion {
        let weight: QuantityConversion = QuantityConversion(quantity: "Weight")

        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Pounds", destinationUnit: "Ounces",
            factor: 16))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Stones", destinationUnit: "Pounds",
            factor: 14))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Pounds", destinationUnit: "Milligrams",
            factor: 453592.37))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Pounds", destinationUnit: "Grams",
            factor: 453.592))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Kilograms", destinationUnit: "Pounds",
            factor: 2.205))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Pounds",
            factor: 2240))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Stones", destinationUnit: "Ounces",
            factor: 224))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Ounces", destinationUnit: "Milligrams",
            factor: 28349.523))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Ounces", destinationUnit: "Grams",
            factor: 28.35))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Kilograms", destinationUnit: "Ounces",
            factor: 35.274))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Ounces",
            factor: 35840))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Stones", destinationUnit: "Milligrams",
            factor: 6350293.18))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Stones", destinationUnit: "Grams",
            factor: 6350.293))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Stones", destinationUnit: "Kilograms",
            factor: 6.35))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Stones",
            factor: 160))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Grams", destinationUnit: "Milligrams",
            factor: 1000))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Kilograms", destinationUnit: "Milligrams",
            factor: 1000000))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Milligrams",
            factor: 1016000000))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Kilograms", destinationUnit: "Grams",
            factor: 1000))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Grams",
            factor: 1016000))
        weight.addConversion(conversion: SimpleConversion(sourceUnit: "Tons", destinationUnit: "Kilograms",
            factor: 1016.047))

        return weight
    }
}
