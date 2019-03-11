//
//  ModalViewController.swift
//  Tiny Timer
//
//  Created by Patrick Kalkman on 10/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit
import SparrowKit

class ModalViewController: UIViewController {
   
   let navBar = SPFakeBarView(style: .stork)
   override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      //self.view = GradientView()
      self.view.backgroundColor = UIColor.purple
      self.modalPresentationCapturesStatusBarAppearance = true
      
      self.navBar.titleLabel.text = "Save timing"
      self.navBar.leftButton.setTitle("Cancel", for: .normal)
      self.navBar.leftButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
      self.navBar.rightButton.setTitle("Save", for: .normal)
      self.navBar.rightButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
      self.view.addSubview(self.navBar)
   }
   
   @objc func dismissAction() {
      self.dismiss(animated: true)
   }
}
