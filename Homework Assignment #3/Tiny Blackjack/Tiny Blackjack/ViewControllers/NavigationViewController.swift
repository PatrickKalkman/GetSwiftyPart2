//
//  NavigationViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 15/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit
import Hero

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.hero.id = "test"
        
        hero.navigationAnimationType = .none
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
