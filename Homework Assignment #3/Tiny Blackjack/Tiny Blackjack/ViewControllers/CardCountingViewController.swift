//
//  CardCountingViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 14/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

class CardCountingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.hero.id = "test"

        self.navigationItem.title = "PRACTICE CARD COUNTING"
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = UIColor.clear
        }

        let textAttributes = [NSAttributedString.Key.foregroundColor:Constants.Colors.LightGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
