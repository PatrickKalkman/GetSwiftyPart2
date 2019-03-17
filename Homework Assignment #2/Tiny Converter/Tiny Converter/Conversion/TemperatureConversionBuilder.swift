//
//  TemperatureConversionBuilder.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 17/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class TemperatureConversionBuilder {

    class func buildTemperatureConversionMatrix() -> QuantityConversion {

        let temperature: QuantityConversion = QuantityConversion(quantity: "Temperature")

        temperature.addConversion(conversion: ComplexConversion(
            sourceUnit: "Celcius", destinationUnit: "Fahrenheit",
            conversionFunctionSourceDestination: { (input: Double) -> Double in return (input * (9.0 / 5.0)) + 32 },
            conversionFunctionDestinationSource: { (input: Double) -> Double in return (input - 32) * 5.0 / 9.0 }))

        temperature.addConversion(conversion: ComplexConversion(
            sourceUnit: "Celcius", destinationUnit: "Kelvin",
            conversionFunctionSourceDestination: { (input: Double) -> Double in return input + 273.15 },
            conversionFunctionDestinationSource: { (input: Double) -> Double in return input - 273.15 }))

        temperature.addConversion(conversion: ComplexConversion(
            sourceUnit: "Fahrenheit", destinationUnit: "Kelvin",
            conversionFunctionSourceDestination: { (input: Double) -> Double in
                return ((input - 32) * 5.0 / 9.0) + 273.15 },
            conversionFunctionDestinationSource: { (input: Double) -> Double in
                return ((input - 273.15) * 9.0 / 5.0) + 32 }))

        return temperature
    }
}
