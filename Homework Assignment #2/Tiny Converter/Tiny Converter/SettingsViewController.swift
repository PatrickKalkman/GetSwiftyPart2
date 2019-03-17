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

    let navBar = SPFakeBarView(style: .stork)

    @IBOutlet weak var tableViewController: UIView!

    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Colors.LightColor
        self.modalPresentationCapturesStatusBarAppearance = true

        self.navBar.titleLabel.text = "Settings"
        self.navBar.titleLabel.textColor = Constants.Colors.SelectedColor
        self.navBar.backgroundColor = Constants.Colors.LightColor

        self.navBar.leftButton.setImage(UIImage(named: Constants.ImageNames.BackButtonImageName)!)
        self.navBar.leftButton.setTitleColor(Constants.Colors.SelectedColor)
        self.navBar.leftButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        self.view.addSubview(self.navBar)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}
