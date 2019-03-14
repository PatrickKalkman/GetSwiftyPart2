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

class ModalTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let lightColor : UIColor = UIColor.init(hex: "E1D3D3")
    let selectedColor : UIColor = UIColor.init(hex: "C55856")
    let navBar = SPFakeBarView(style: .stork)
    let tableView = UITableView()
    let unitConverter : UnitConverter
    var functionToFinish: (() -> Void)
    var selectionMode: SelectionMode
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default}
    
    init(unitConverter: UnitConverter, selectionMode: SelectionMode, functionToFinish: @escaping (() -> Void)) {
        self.unitConverter = unitConverter
        self.functionToFinish = functionToFinish
        self.selectionMode = selectionMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = lightColor
        self.modalPresentationCapturesStatusBarAppearance = true
        
        self.tableView.backgroundColor = lightColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.contentInset.top = self.navBar.height
        self.tableView.scrollIndicatorInsets.top = self.navBar.height
        self.view.addSubview(self.tableView)
        
        if self.selectionMode == SelectionMode.Quantity {
            self.navBar.titleLabel.text = "Select Quantity"
        } else {
            self.navBar.titleLabel.text = "Select Quantity"
        }

        self.navBar.titleLabel.textColor = selectedColor
        self.navBar.backgroundColor = lightColor
        self.navBar.leftButton.setTitle("<", for: .normal)
        self.navBar.leftButton.setTitleColor(selectedColor)
        self.navBar.leftButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        self.view.addSubview(self.navBar)
        
        self.updateLayout(with: self.view.frame.size)
    }
    
    override func viewWillAppear(_ animated: Bool) {

        let indexPath : IndexPath = IndexPath(row: unitConverter.SelectedQuantityIndex, section: 0)
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
        return unitConverter.Quantities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = lightColor
        cell.selectionStyle = .blue
        
        if self.selectionMode == SelectionMode.Quantity {
            cell.textLabel?.text = unitConverter.Quantities[indexPath.row]
        } else {
            cell.textLabel?.text = unitConverter.Units[indexPath.row]
        }
        
        cell.transform = .identity

        let customView : UIView = UIView()
        customView.backgroundColor = selectedColor
        cell.textLabel?.textColor = selectedColor
        cell.textLabel?.highlightedTextColor = lightColor
        cell.selectedBackgroundView = customView

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.selectionMode == SelectionMode.Quantity {
            let selectedItem : String = unitConverter.Quantities[indexPath.row]
            unitConverter.SelectedQuantity = selectedItem
            unitConverter.SelectedQuantityIndex = indexPath.row
        } else if self.selectionMode == SelectionMode.SourceUnit {
            let selectedItem : String = unitConverter.Units[indexPath.row]
            unitConverter.SelectedSourceUnit = selectedItem
            unitConverter.SelectedSourceUnitIndex = indexPath.row
        } else if self.selectionMode == SelectionMode.DestinationUnit {
            let selectedItem : String = unitConverter.Units[indexPath.row]
            unitConverter.SelectedDestinationUnit = selectedItem
            unitConverter.SelectedDestinationUnitIndex = indexPath.row
        }
        functionToFinish()
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}
