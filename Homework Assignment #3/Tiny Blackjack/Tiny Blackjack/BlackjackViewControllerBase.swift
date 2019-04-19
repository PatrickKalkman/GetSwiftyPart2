//
//  BlackjackViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 19/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

class BlackjackViewControllerBase : UIViewController {
    
    override func viewDidLoad() {
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = UIColor.clear
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setTitle(_ title: String) {
        self.navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:Constants.Colors.LightGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
