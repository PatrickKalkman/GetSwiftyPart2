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

class SettingsViewController: UIViewController {
    
    let lightColor : UIColor = UIColor.init(hex: "E1D3D3")
    let selectedColor : UIColor = UIColor.init(hex: "C55856")
    let navBar = SPFakeBarView(style: .stork)
//    var functionToFinish: (() -> Void)

    @IBOutlet weak var tableViewController: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default}
    
//    init(functionToFinish: @escaping (() -> Void)) {
//        self.functionToFinish = functionToFinish
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) is not supported")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = lightColor
        self.modalPresentationCapturesStatusBarAppearance = true

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
        //self.tableView.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
    
}

