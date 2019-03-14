//
//  UnitConverter.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 14/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class UnitConverter {
    
    let Quantities : [String] = ["Weight", "Volume", "Length", "Temperature"]
    
    let Units : [String] = ["Inches", "Feets", "Yards", "Miles", "Millimeters", "Centimeters", "Meters", "Kilometers"]
    
    var SelectedQuantity : String
    var SelectedQuantityIndex : Int
    
    var SelectedSourceUnit : String
    var SelectedSourceUnitIndex : Int
    
    var SelectedDestinationUnit : String
    var SelectedDestinationUnitIndex : Int
    
    init() {
        SelectedQuantityIndex = 2
        SelectedQuantity = Quantities[SelectedQuantityIndex]
        
        SelectedSourceUnitIndex = 0
        SelectedSourceUnit = Units[SelectedSourceUnitIndex]
        
        SelectedDestinationUnitIndex = 5
        SelectedDestinationUnit = Units[SelectedDestinationUnitIndex]
    }
}
