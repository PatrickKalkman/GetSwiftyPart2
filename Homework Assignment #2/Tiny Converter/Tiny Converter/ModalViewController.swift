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
    let selectedQuantity: String
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default}
    
    init(unitConverter: UnitConverter, selectionMode: SelectionMode, selectedQuantity: String, functionToFinish: @escaping (() -> Void)) {
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
            self.navBar.titleLabel.text = "Select Unit"
        }

        self.navBar.titleLabel.textColor = selectedColor
        self.navBar.backgroundColor = lightColor
        
        self.navBar.leftButton.setImage(UIImage(named: "backButton")!)
        self.navBar.leftButton.setTitleColor(selectedColor)
        self.navBar.leftButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        self.view.addSubview(self.navBar)
        
        self.updateLayout(with: self.view.frame.size)
    }
    
    override func viewWillAppear(_ animated: Bool) {

        var indexPath : IndexPath
        if self.selectionMode == SelectionMode.Quantity {
            indexPath = IndexPath(row: unitConverter.SelectedQuantityIndex, section: 0)
        } else if self.selectionMode == SelectionMode.SourceUnit {
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
        if self.selectionMode == SelectionMode.Quantity {
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
        cell.backgroundColor = lightColor
        cell.selectionStyle = .blue
        
        if self.selectionMode == SelectionMode.Quantity {
            cell.textLabel?.text = unitConverter.getQuantities()[indexPath.row]
        } else {
            cell.textLabel?.text = unitConverter.getUnits(quantity: selectedQuantity)[indexPath.row]
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
            let selectedItem : String = unitConverter.getQuantities()[indexPath.row]
            unitConverter.SelectedQuantity = selectedItem
            unitConverter.SelectedQuantityIndex = indexPath.row
        } else if self.selectionMode == SelectionMode.SourceUnit {
            let selectedItem : String = unitConverter.getUnits(quantity: selectedQuantity)[indexPath.row]
            unitConverter.SelectedSourceUnit = selectedItem
            unitConverter.SelectedSourceUnitIndex = indexPath.row
        } else if self.selectionMode == SelectionMode.DestinationUnit {
            let selectedItem : String = unitConverter.getUnits(quantity: selectedQuantity)[indexPath.row]
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

let TipInCellAnimatorStartTransform:CATransform3D = {
    let rotationDegrees: CGFloat = -45.0
    let rotationRadians: CGFloat = rotationDegrees * (CGFloat(Double.pi)/180.0)
    let offset = CGPoint(x: -30, y: -30)
    var startTransform = CATransform3DIdentity
    startTransform = CATransform3DRotate(CATransform3DIdentity,
                                         rotationRadians, 0.0, 0.0, 1.0)
    startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
    
    return startTransform
}()

class TipInCellAnimator {
    class func animate(cell:UITableViewCell) {
        let view = cell.contentView
        
        view.layer.transform = TipInCellAnimatorStartTransform
        view.layer.opacity = 0.8
        
        UIView.animate(withDuration: 0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
}
