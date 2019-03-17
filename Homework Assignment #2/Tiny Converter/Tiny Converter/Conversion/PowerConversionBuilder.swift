//
//  PowerConversionBuilder.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 17/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class PowerConversionBuilder {

    class func buildPowerConversionMatrix() -> QuantityConversion {
        let power: QuantityConversion = QuantityConversion(quantity: "Power")

        power.addConversion(conversion: SimpleConversion(sourceUnit: "Horse Power", destinationUnit: "btu/h",
            factor: 2544.43))
        power.addConversion(conversion: SimpleConversion(sourceUnit: "Kilowatt", destinationUnit: "btu/h",
            factor: 3412.14))
        power.addConversion(conversion: SimpleConversion(sourceUnit: "Watt", destinationUnit: "btu/h",
            factor: 3.4121))
        power.addConversion(conversion: SimpleConversion(sourceUnit: "Tonne of refr.", destinationUnit: "btu/h",
            factor: 12000))

        power.addConversion(conversion: SimpleConversion(sourceUnit: "Kilowatt", destinationUnit: "Horse Power",
            factor: 1.3596))
        power.addConversion(conversion: SimpleConversion(sourceUnit: "Horse Power", destinationUnit: "Watt",
            factor: 735.50))
        power.addConversion(conversion: SimpleConversion(sourceUnit: "Tonne of refr.", destinationUnit: "Horse Power",
            factor: 4.7816))

        power.addConversion(conversion: SimpleConversion(sourceUnit: "Kilowatt", destinationUnit: "Watt",
            factor: 1000))
        power.addConversion(conversion: SimpleConversion(sourceUnit: "Tonne of refr.", destinationUnit: "Kilowatt",
            factor: 3.5169))

        power.addConversion(conversion: SimpleConversion(sourceUnit: "Tonne of refr.", destinationUnit: "Watt",
            factor: 3516.8528))

        return power
    }
}
