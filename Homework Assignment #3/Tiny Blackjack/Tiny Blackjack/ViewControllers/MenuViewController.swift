//
//  MenuViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 13/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var dismissButton: UIButton?
    var titleLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = UIColor.clear
        }
        let textAttributes = [NSAttributedString.Key.foregroundColor:Constants.Colors.LightGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.backgroundColor = UIColor.clear
    }
    
    @IBAction func showSettings(_ sender: Any) {
        self.performSegue(withIdentifier: "settings", sender: self)
    }
    
    @IBAction func playBasicStrategy(_ sender: Any) {
        self.performSegue(withIdentifier: "basicStrategy", sender: self)
    }
    
    @IBAction func playCardCounting(_ sender: Any) {
        self.performSegue(withIdentifier: "cardCounting", sender: self)
    }
    
    @IBAction func playBlackjack(_ sender: UIButton) {
        self.performSegue(withIdentifier: "playBlackjack", sender: self)
        
    }
}
