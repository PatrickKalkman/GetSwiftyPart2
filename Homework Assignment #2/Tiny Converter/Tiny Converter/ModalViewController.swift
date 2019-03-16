//
//  ModalViewController.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 13/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import SPStorkController
import SparrowKit

// Controller to select the quantity, source unit or destination unit
// of a conversion
class ModalTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let navBar = SPFakeBarView(style: .stork)
    let tableView = UITableView()
    let unitConverter : UnitConverter
    var functionToFinish: ((_ direction: CalculationDirection) -> Void)
    var selectionMode: ModalSelectionMode
    let selectedQuantity: String
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default}
    
    init(unitConverter: UnitConverter, selectionMode: ModalSelectionMode, selectedQuantity: String, functionToFinish: @escaping ((_ direction: CalculationDirection) -> Void)) {
        self.unitConverter = unitConverter
        self.functionToFinish = functionToFinish
        self.selectionMode = selectionMode
        self.selectedQuantity = selectedQuantity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Colors.LightColor
        self.modalPresentationCapturesStatusBarAppearance = true
        
        self.tableView.backgroundColor = Constants.Colors.LightColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.contentInset.top = self.navBar.height
        self.tableView.scrollIndicatorInsets.top = self.navBar.height
        self.view.addSubview(self.tableView)
        
        if self.selectionMode == ModalSelectionMode.Quantity {
            self.navBar.titleLabel.text = "Select Quantity"
        } else {
            self.navBar.titleLabel.text = "Select Unit"
        }

        self.navBar.titleLabel.textColor = Constants.Colors.SelectedColor
        self.navBar.backgroundColor = Constants.Colors.LightColor
        
        self.navBar.leftButton.setImage(UIImage(named: "backButton")!)
        self.navBar.leftButton.setTitleColor(Constants.Colors.SelectedColor)
        self.navBar.leftButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        self.view.addSubview(self.navBar)
        
        self.updateLayout(with: self.view.frame.size)
    }
    
    override func viewWillAppear(_ animated: Bool) {

        var indexPath : IndexPath
        if self.selectionMode == ModalSelectionMode.Quantity {
            indexPath = IndexPath(row: unitConverter.SelectedQuantityIndex, section: 0)
        } else if self.selectionMode == ModalSelectionMode.SourceUnit {
            indexPath = IndexPath(row: unitConverter.SelectedSourceUnitIndex, section: 0)
        } else {
            indexPath = IndexPath(row: unitConverter.SelectedDestinationUnitIndex, section: 0)
        }
        
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.updateLayout(with: self.view.frame.size)
    }
    
    func updateLayout(with size: CGSize) {
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectionMode == ModalSelectionMode.Quantity {
            return unitConverter.getQuantities().count
        } else {
            return unitConverter.getUnits(quantity: selectedQuantity).count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        TipInCellAnimator.animate(cell: cell)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = Constants.Colors.LightColor
        cell.selectionStyle = .blue
        
        if self.selectionMode == ModalSelectionMode.Quantity {
            cell.textLabel?.text = unitConverter.getQuantities()[indexPath.row]
        } else {
            cell.textLabel?.text = unitConverter.getUnits(quantity: selectedQuantity)[indexPath.row]
        }
        
        cell.transform = .identity

        let customView : UIView = UIView()
        customView.backgroundColor = Constants.Colors.SelectedColor
        cell.textLabel?.textColor = Constants.Colors.SelectedColor
        cell.textLabel?.highlightedTextColor = Constants.Colors.LightColor
        cell.selectedBackgroundView = customView

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.selectionMode == ModalSelectionMode.Quantity {
            let selectedItem : String = unitConverter.getQuantities()[indexPath.row]
            unitConverter.SelectedQuantity = selectedItem
            unitConverter.SelectedQuantityIndex = indexPath.row
        } else if self.selectionMode == ModalSelectionMode.SourceUnit {
            let selectedItem : String = unitConverter.getUnits(quantity: selectedQuantity)[indexPath.row]
            unitConverter.SelectedSourceUnit = selectedItem
            unitConverter.SelectedSourceUnitIndex = indexPath.row
        } else if self.selectionMode == ModalSelectionMode.DestinationUnit {
            let selectedItem : String = unitConverter.getUnits(quantity: selectedQuantity)[indexPath.row]
            unitConverter.SelectedDestinationUnit = selectedItem
            unitConverter.SelectedDestinationUnitIndex = indexPath.row
        }
        functionToFinish(CalculationDirection.SourceToDestination)
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}
