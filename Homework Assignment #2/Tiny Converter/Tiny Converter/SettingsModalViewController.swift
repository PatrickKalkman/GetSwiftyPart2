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

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let lightColor : UIColor = UIColor.init(hex: "E1D3D3")
    let selectedColor : UIColor = UIColor.init(hex: "C55856")
    let navBar = SPFakeBarView(style: .stork)
    let tableView = UITableView()
    var functionToFinish: (() -> Void)

    override var preferredStatusBarStyle: UIStatusBarStyle { return .default}
    
    init(functionToFinish: @escaping (() -> Void)) {
        self.functionToFinish = functionToFinish
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
        
        self.navBar.titleLabel.text = "Settings"
        self.navBar.titleLabel.textColor = selectedColor
        self.navBar.backgroundColor = lightColor
        
        self.navBar.leftButton.setImage(UIImage(named: "backButton")!)
        self.navBar.leftButton.setTitleColor(selectedColor)
        self.navBar.leftButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        self.view.addSubview(self.navBar)
        
        self.updateLayout(with: self.view.frame.size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        TipInCellAnimator.animate(cell: cell)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = lightColor
        cell.selectionStyle = .blue
        
        cell.transform = .identity
        
        let customView : UIView = UIView()
        customView.backgroundColor = selectedColor
        cell.textLabel?.textColor = selectedColor
        cell.textLabel?.highlightedTextColor = lightColor
        cell.selectedBackgroundView = customView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        functionToFinish()
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
    
}

