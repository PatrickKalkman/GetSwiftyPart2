//
//  AreaConversionBuilder.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 17/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class AreaConversionBuilder {
    class func buildAreaConversionMatrix() -> QuantityConversion {

        let area: QuantityConversion = QuantityConversion(quantity: "Area")

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Are",
            factor: 40.5))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Are",
            factor: 2.5))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Centimeter",
            factor: 40468564.2))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Decimeter",
            factor: 404685.6))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Foot",
            factor: 43560))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Acre",
            factor: 2.5))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Inch",
            factor: 6272640))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Acre",
            factor: 247.1))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Meter",
            factor: 4046.9))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Micrometer",
            factor: 4046856422000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Acre",
            factor: 640))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Millimeter",
            factor: 4046856422))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Nanometer",
            factor: 4046856421999999713280))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Acre", destinationUnit: "Sq Yard",
            factor: 4840))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Are",
            factor: 100))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Centimeter",
            factor: 1000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Decimeter",
            factor: 10000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Foot",
            factor: 1076.4))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Are",
            factor: 2.5))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Inch",
            factor: 1550003))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Are",
            factor: 10000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Meter",
            factor: 100))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Micrometer",
            factor: 100000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Are",
            factor: 25899.9))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Millimeter",
            factor: 100000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Nanometer",
            factor: 100000000000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Are", destinationUnit: "Sq Yard",
            factor: 119.6))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Centimeter",
            factor: 100000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Decimeter",
            factor: 1000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Foot",
            factor: 107639.1))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Hectare",
            factor: 1))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Inch",
            factor: 15500031))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Hectare",
            factor: 100))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Meter",
            factor: 10000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Micrometer",
            factor: 10000000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Hectare",
            factor: 259))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Millimeter",
            factor: 10000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Nanometer",
            factor: 10000000000000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Hectare", destinationUnit: "Sq Yard",
            factor: 11959.9))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Decimeter", destinationUnit: "Sq Centimeter",
            factor: 100))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Centimeter",
            factor: 929))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Centimeter",
            factor: 100000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Inch", destinationUnit: "Sq Centimeter",
            factor: 6.5))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Centimeter",
            factor: 10000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Centimeter",
            factor: 100000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Centimer", destinationUnit: "Sq Micrometer",
            factor: 100000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Centimer",
            factor: 25899881100))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Centimer", destinationUnit: "Sq Millimeter",
            factor: 100))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Centimer", destinationUnit: "Sq Nanometer",
            factor: 100000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Centimer",
            factor: 8361.3))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Decimeter",
            factor: 9.3))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Decimeter",
            factor: 1000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Decimeter", destinationUnit: "Sq Inch",
            factor: 15.5))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Decimeter",
            factor: 100000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Decimeter",
            factor: 100))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Decimeter", destinationUnit: "Sq Micrometer",
            factor: 10000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Decimeter",
            factor: 258998811))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Decimeter", destinationUnit: "Sq Millimeter",
            factor: 10000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Decimeter", destinationUnit: "Sq Nanometer",
            factor: 10000000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Decimeter",
            factor: 83.613))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Foot",
            factor: 107639.1))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Inch",
            factor: 144))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Foot",
            factor: 10763910.4))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Foot",
            factor: 10.8))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Micrometer",
            factor: 92903040000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Foot",
            factor: 27878400))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Millimeter",
            factor: 92903))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Foot", destinationUnit: "Sq Nanometer",
            factor: 92903040000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Foot",
            factor: 9))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Inch",
            factor: 15500031))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Hectometer",
            factor: 100))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Meter",
            factor: 10000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Micrometer",
            factor: 10000000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Hectometer",
            factor: 259))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Millimeter",
            factor: 10000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Nanometer",
            factor: 10000000000000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Hectometer", destinationUnit: "Sq Yard",
            factor: 11959.9))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Inch",
            factor: 1550003100))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Inch",
            factor: 1550))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Inch", destinationUnit: "Sq Micrometer",
            factor: 645160000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Inch",
            factor: 4014489599.5))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Inch", destinationUnit: "Sq Millimeter",
            factor: 645.2))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Inch", destinationUnit: "Sq Nanometer",
            factor: 6451599999999999))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Inch",
            factor: 1296))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Meter",
            factor: 1000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Micrometer",
            factor: 1000000000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Kilometer",
            factor: 2.6))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Millimeter",
            factor: 1000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Nanometer",
            factor: 999999999999999983222784))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Kilometer", destinationUnit: "Sq Yard",
            factor: 1195990))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Micrometer",
            factor: 1000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Meter",
            factor: 2589988.1))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Millimeter",
            factor: 1000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Nanometer",
            factor: 999999999999999872))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Meter", destinationUnit: "Sq Yard",
            factor: 1.2))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Micrometer",
            factor: 2589988110000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Millimeter", destinationUnit: "Sq Micrometer",
            factor: 1000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Micrometer", destinationUnit: "Sq Nanometer",
            factor: 1000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Micrometer",
            factor: 836127360000))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Millimeter",
            factor: 2589988110000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Nanometer",
            factor: 2589988109999999809486848))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Mile", destinationUnit: "Sq Yard",
            factor: 3097600))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Millimeter", destinationUnit: "Sq Nanometer",
            factor: 1000000000000))
        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Millimeter",
            factor: 836127.4))

        area.addConversion(conversion: SimpleConversion(sourceUnit: "Sq Yard", destinationUnit: "Sq Nanometer",
            factor: 836127359999999872))

        return area
    }
}
