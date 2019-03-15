//
//  ViewController.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 13/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import SPStorkController

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var topGradient: GradientView!
    @IBOutlet weak var bottomGradient: GradientView!
    @IBOutlet weak var quantityButton: UIButton!
    @IBOutlet weak var sourceUnitButton: UIButton!
    @IBOutlet weak var destinationUnitButton: UIButton!
    @IBOutlet weak var sourceTextField: DesignableUITextField!
    @IBOutlet weak var destinationTextField: DesignableUITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let converter: UnitConverter = UnitConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
        sourceTextField.delegate = self
        destinationTextField.delegate = self
        converter.setDefault()
        refresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    @IBAction func convertButtonAction(_ sender: Any) {
        
        guard let inputString : String = sourceTextField.text else {
            print("No input available")
            return
        }
        
        guard let input = Double(inputString) else {
            print("Cannot convert \(inputString)")
            return
        }
        
        guard var quantity : String = quantityButton.titleLabel?.text else {
            print("No quantity chosen")
            return
        }
        quantity = quantity.replace("  ▾", with: "")
        
        guard var sourceUnit : String = sourceUnitButton.titleLabel?.text else {
            print("No source unit chosen")
            return
        }
        sourceUnit = sourceUnit.replace("▾ ", with: "")
        
        guard var destinationUnit : String = destinationUnitButton.titleLabel?.text else {
            print("No destination unit chosen")
            return
        }
        destinationUnit = destinationUnit.replace("▾ ", with: "")
        
        let result : Double = converter.Convert(quantity: quantity,
                          sourceUnit: sourceUnit,
                          destinationUnit: destinationUnit,
                          input: input)
        
        destinationTextField.text = String(format: "%.2f", result)
    }
    
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIControl.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIControl.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        
        let tabbarHeight = tabBarController?.tabBar.frame.size.height ?? 0
        let toolbarHeight = navigationController?.toolbar.frame.size.height ?? 0
        let bottomInset = keyboardSize.height - tabbarHeight - toolbarHeight
        
        scrollView.contentInset.bottom = bottomInset
        scrollView.scrollIndicatorInsets.bottom = bottomInset
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(false)
    }

    @IBAction func SelectQuantity(_ sender: Any) {
        showModal(selectionMode: SelectionMode.Quantity, functionToFinish: setDefaultAndRefresh)
    }
    
    @IBAction func SelectSourceUnit(_ sender: Any) {
        showModal(selectionMode: SelectionMode.SourceUnit, functionToFinish: refresh)
    }
    
    @IBAction func SelectDestinationUnit(_ sender: Any) {
        showModal(selectionMode: SelectionMode.DestinationUnit, functionToFinish: refresh)
    }
    
    func showModal(selectionMode: SelectionMode, functionToFinish: @escaping (() -> Void)) {
        
        guard var quantity : String = quantityButton.titleLabel?.text else {
            print("No quantity chosen")
            return
        }
        quantity = quantity.replace("  ▾", with: "")
        
        let modal = ModalTableViewController(unitConverter: converter, selectionMode: selectionMode, selectedQuantity: quantity, functionToFinish: functionToFinish)
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
    
    func setDefaultAndRefresh() {
        
        guard var quantity : String = quantityButton.titleLabel?.text else {
            print("No quantity chosen")
            return
        }
        quantity = quantity.replace("  ▾", with: "")
        
        if (self.converter.SelectedQuantity != quantity) {
            self.converter.setDefault(selectedQuantity: self.converter.SelectedQuantity)
        }
        
        refresh()
    }
    
    let numbers = "0123456789.,";
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.count > 0 ? numbers.contains(string) : true
    }
}

