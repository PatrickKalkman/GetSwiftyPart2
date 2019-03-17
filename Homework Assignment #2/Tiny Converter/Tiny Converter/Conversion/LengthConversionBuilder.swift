//
//  LengthConversionBuilder.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 17/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class LengthConversionBuilder {

    class func buildLengthConversionMatrix() -> QuantityConversion {
        let length: QuantityConversion = QuantityConversion(quantity: "Length")

        length.addConversion(conversion: SimpleConversion(sourceUnit: "Feet", destinationUnit: "Inches",
            factor: 12.0))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Yards", destinationUnit: "Inches",
            factor: 16.0))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Inches",
            factor: 63360.0))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Inches", destinationUnit: "Millimeters",
            factor: 25.4))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Inches", destinationUnit: "Centimeters",
            factor: 2.54))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Inches",
            factor: 39.37))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Inches",
            factor: 39370.079))

        length.addConversion(conversion: SimpleConversion(sourceUnit: "Yards", destinationUnit: "Feet",
            factor: 3))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Feet",
            factor: 5280))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Feet", destinationUnit: "Millimeters",
            factor: 304.8))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Feet", destinationUnit: "Centimeters",
            factor: 30.48))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Feet",
            factor: 3.281))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Feet",
            factor: 3280.84))

        length.addConversion(conversion: SimpleConversion(sourceUnit: "Yards", destinationUnit: "Feet",
            factor: 3))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Feet",
            factor: 5280))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Feet", destinationUnit: "Millimeters",
            factor: 304.8))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Feet", destinationUnit: "Centimeters",
            factor: 30.48))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Feet",
            factor: 3.281))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Feet",
            factor: 3280.84))

        length.addConversion(conversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Yards",
            factor: 1760))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Yards", destinationUnit: "Millimeters",
            factor: 914.4))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Yards", destinationUnit: "Centimeters",
            factor: 91.44))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Yards",
            factor: 1.094))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Yards",
            factor: 1093.613))

        length.addConversion(conversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Millimeters",
            factor: 1609344))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Centimeters",
            factor: 160934.4))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Meters",
            factor: 1609.344))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Miles", destinationUnit: "Kilometers",
            factor: 1.60934))

        length.addConversion(conversion: SimpleConversion(sourceUnit: "Centimeters", destinationUnit: "Millimeters",
            factor: 10))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Millimeters",
            factor: 1000))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Millimeters",
            factor: 1000000))

        length.addConversion(conversion: SimpleConversion(sourceUnit: "Meters", destinationUnit: "Centimeters",
            factor: 100))
        length.addConversion(conversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Centimeters",
            factor: 100000))

        length.addConversion(conversion: SimpleConversion(sourceUnit: "Kilometers", destinationUnit: "Meters",
            factor: 1000))

        return length
    }
}
