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
        
    @IBOutlet weak var quantityButton: UIButton!
    @IBOutlet weak var sourceUnitButton: UIButton!
    @IBOutlet weak var destinationUnitButton: UIButton!
    
    let converter: UnitConverter = UnitConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refresh()
    }

    @IBAction func SelectQuantity(_ sender: Any) {
        let modal = ModalTableViewController(unitConverter: converter, selectionMode: SelectionMode.Quantity, functionToFinish: refresh)
        let transitionDelegate = SPStorkTransitioningDelegate()
        modal.transitioningDelegate = transitionDelegate
        modal.modalPresentationStyle = .custom
        self.present(modal, animated: true, completion: nil)
    }
    
    @IBAction func SelectSourceUnit(_ sender: Any) {
        let modal = ModalTableViewController(unitConverter: converter, selectionMode: SelectionMode.SourceUnit, functionToFinish: refresh)
        let transitionDelegate = SPStorkTransitioningDelegate()
        modal.transitioningDelegate = transitionDelegate
        modal.modalPresentationStyle = .custom
        self.present(modal, animated: true, completion: nil)
    }
    
    @IBAction func SelectDestinationUnit(_ sender: Any) {
        let modal = ModalTableViewController(unitConverter: converter, selectionMode: SelectionMode.DestinationUnit, functionToFinish: refresh)
        let transitionDelegate = SPStorkTransitioningDelegate()
        modal.transitioningDelegate = transitionDelegate
        modal.modalPresentationStyle = .custom
        self.present(modal, animated: true, completion: nil)
    }
    
    func refresh() {
       let transitionTime : Double = 1.2
        UIView.transition(with: quantityButton, duration: transitionTime, options: .transitionCrossDissolve, animations: {
            self.quantityButton.setTitle("\(self.converter.SelectedQuantity)  ▾")
        }, completion: nil)
        
        UIView.transition(with: sourceUnitButton, duration: transitionTime, options: .transitionCrossDissolve, animations: {
            self.sourceUnitButton.setTitle("▾ \(self.converter.SelectedSourceUnit)")
        }, completion: nil)
        
        UIView.transition(with: destinationUnitButton, duration: transitionTime, options: .transitionCrossDissolve, animations: {
            self.destinationUnitButton.setTitle("▾ \(self.converter.SelectedDestinationUnit)")
        }, completion: nil)

    }
}

