//
//  ViewController.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 13/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import SPStorkController

class MainViewController: UIViewController, UITextFieldDelegate {

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
        refresh(direction: CalculationDirection.sourceToDestination)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }

    @IBAction func showSettingButton(_ sender: Any) {

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let settingsViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewId")
            as? SettingsViewController {
            let transitionDelegate = SPStorkTransitioningDelegate()
            settingsViewController.transitioningDelegate = transitionDelegate
            settingsViewController.modalPresentationStyle = .custom
            self.present(settingsViewController, animated: true, completion: nil)
        }
    }

    @IBAction func sourceNumberChanged(_ sender: UITextView) {
        convert(direction: CalculationDirection.sourceToDestination)
    }

    @IBAction func destinationNumberChanged(_ sender: UITextField) {
        convert(direction: CalculationDirection.destinationToSource)
    }

    @IBAction func convertButtonAction(_ sender: Any) {
        convert(direction: CalculationDirection.sourceToDestination)
    }

    func convert(direction: CalculationDirection) {

        var inputString: String

        if direction == CalculationDirection.sourceToDestination {
            guard let inputStringFromSource: String = sourceTextField.text else {
                print("No source input available")
                return
            }
            inputString = inputStringFromSource
        } else {
            guard let inputStringFromDestination: String = destinationTextField.text else {
                print("No destination input available")
                return
            }
            inputString = inputStringFromDestination
        }

        guard let input = Double(inputString) else {
            print("Cannot convert \(inputString)")
            return
        }

        let result: Double = converter.convert(input: input, direction: direction)

        let numberOfDecimals: Int = SettingsBundleHelper.getNumberOfDecimals()
        let formattedResult: String = String(format: "%.\(numberOfDecimals)f", result)

        if direction == CalculationDirection.sourceToDestination {
            destinationTextField.text = formattedResult
        } else {
            sourceTextField.text = formattedResult
        }
    }

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
            name: UIControl.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
            name: UIControl.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let userInfo: NSDictionary = notification.userInfo as NSDictionary? {
            if let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardSize = keyboardFrame.cgRectValue.size
                let tabbarHeight = tabBarController?.tabBar.frame.size.height ?? 0
                let toolbarHeight = navigationController?.toolbar.frame.size.height ?? 0
                let bottomInset = keyboardSize.height - tabbarHeight - toolbarHeight

                scrollView.contentInset.bottom = bottomInset
                scrollView.scrollIndicatorInsets.bottom = bottomInset
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(false)
    }

    @IBAction func selectQuantity(_ sender: Any) {
        showModal(selectionMode: ModalSelectionMode.quantity, functionToFinish: setDefaultAndRefresh)
    }

    @IBAction func selectSourceUnit(_ sender: Any) {
        showModal(selectionMode: ModalSelectionMode.sourceUnit, functionToFinish: refresh)
    }

    @IBAction func selectDestinationUnit(_ sender: Any) {
        showModal(selectionMode: ModalSelectionMode.destinationUnit, functionToFinish: refresh)
    }

    func showModal(selectionMode: ModalSelectionMode,
                   functionToFinish: @escaping ((_ direction: CalculationDirection) -> Void)) {

        guard var quantity: String = quantityButton.titleLabel?.text else {
            print("No quantity chosen")
            return
        }

        quantity = quantity.replace("  ▾", with: "")

        let modal = ModalTableViewController(unitConverter: converter, selectionMode: selectionMode,
            selectedQuantity: quantity, functionToFinish: functionToFinish)
        let transitionDelegate = SPStorkTransitioningDelegate()
        modal.transitioningDelegate = transitionDelegate
        modal.modalPresentationStyle = .custom
        self.present(modal, animated: true, completion: nil)
    }

    func refresh(direction: CalculationDirection) {

        let transitionTime: Double = 1.2

        UIView.transition(with: quantityButton, duration: transitionTime,
            options: .transitionCrossDissolve, animations: {
                self.quantityButton.setTitle("\(self.converter.selectedQuantity)  ▾")
            }, completion: nil)

        UIView.transition(with: sourceUnitButton, duration: transitionTime,
            options: .transitionCrossDissolve, animations: {
                self.sourceUnitButton.setTitle("▾ \(self.converter.selectedSourceUnit)")
            }, completion: nil)

        UIView.transition(with: destinationUnitButton, duration: transitionTime,
            options: .transitionCrossDissolve, animations: {
                self.destinationUnitButton.setTitle("▾ \(self.converter.selectedDestinationUnit)")
            }, completion: nil)

        convert(direction: direction)
    }

    func setDefaultAndRefresh(direction: CalculationDirection) {

        guard var quantity: String = quantityButton.titleLabel?.text else {
            print("No quantity chosen")
            return
        }
        quantity = quantity.replace("  ▾", with: "")

        if self.converter.selectedQuantity != quantity {
            self.converter.setDefault(selectedQuantity: self.converter.selectedQuantity)
        }

        refresh(direction: CalculationDirection.sourceToDestination)
    }

    // Allow only numbers and . ,
    let numbers: String = "0123456789.,"
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return string.count > 0 ? numbers.contains(string) : true
    }
}
