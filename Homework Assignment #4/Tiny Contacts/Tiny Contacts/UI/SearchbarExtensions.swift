//
//  SearchbarExtensions.swift
//  Tiny Contacts
//
//  Created by Patrick Kalkman on 05/05/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    private func getViewElement<T>(type: T.Type) -> T? {
        
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    
    func setTextFieldColor(color: UIColor) {
        
        if let textField = getViewElement(type: UITextField.self) {
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 6
                
            case .prominent, .default:
                textField.backgroundColor = color
            @unknown default:
                print("Unknown Searchbar Style")
            }
        }
    }
    
    func setTextColor(color: UIColor) {
        
        if let textField = getViewElement(type: UITextField.self) {
            textField.textColor = color
        }
    }
}
