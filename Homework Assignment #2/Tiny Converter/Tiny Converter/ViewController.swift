//
//  ViewController.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 13/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import SPStorkController

class ViewController: UIViewController {
        
    @IBOutlet weak var quantityLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }


    @IBAction func SelectQuantity(_ sender: Any) {
        let modal = ModalTableViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        modal.transitioningDelegate = transitionDelegate
        modal.modalPresentationStyle = .custom
        self.present(modal, animated: true, completion: nil)
        
    }
}

