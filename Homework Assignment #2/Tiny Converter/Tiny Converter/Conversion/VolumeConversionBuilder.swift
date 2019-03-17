//
//  VolumeConversionBuilder.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 17/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class VolumeConversionBuilder {
    class func buildVolumeConversionMatrix() -> QuantityConversion {

        let volume: QuantityConversion = QuantityConversion(quantity: "Volume")

        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Tablespoon", destinationUnit: "Teaspoon",
            factor: 3))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Cups", destinationUnit: "Teaspoon",
            factor: 48))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Teaspoon",
            factor: 192))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Teaspoon",
            factor: 639.494))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Teaspoon", destinationUnit: "Milliliters",
            factor: 5.919))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Deciliters", destinationUnit: "Teaspoon",
            factor: 20))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Liters", destinationUnit: "Teaspoon",
            factor: 168.936))

        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Cups", destinationUnit: "Tablespoon",
            factor: 16))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Tablespoon",
            factor: 64))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Tablespoon",
            factor: 213.165))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Tablespoon", destinationUnit: "Milliliters",
            factor: 17.758))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Deciliters", destinationUnit: "Tablespoon",
            factor: 6.763))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Liters", destinationUnit: "Tablespoon",
            factor: 56.3121))

        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Cups",
            factor: 4))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Cups",
            factor: 13.323))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Cups", destinationUnit: "Milliliters",
            factor: 284.131))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Cups", destinationUnit: "Deciliters",
            factor: 2.841))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Liters", destinationUnit: "Cups",
            factor: 3.52))

        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Quarts",
            factor: 3.331))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Milliliters",
            factor: 3785.412))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Deciliters",
            factor: 11.3652))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Quarts", destinationUnit: "Liters",
            factor: 1.13652))

        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Milliliters",
            factor: 3785.41))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Deciliters",
            factor: 37.8541))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Gallons", destinationUnit: "Liters",
            factor: 3.78541))

        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Deciliters", destinationUnit: "Milliliters",
            factor: 100))
        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Liters", destinationUnit: "Milliliters",
            factor: 1000))

        volume.addConversion(conversion: SimpleConversion(sourceUnit: "Liters", destinationUnit: "Deciliters",
            factor: 10))

        return volume
    }
}
