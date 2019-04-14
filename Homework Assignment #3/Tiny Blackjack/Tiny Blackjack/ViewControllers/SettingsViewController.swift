//
//  SettingsViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 14/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var soundOn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Settings"
        let textAttributes = [NSAttributedString.Key.foregroundColor:Constants.Colors.DarkGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        versionLabel.text = SettingsBundleHelper.getVersion()
        buildLabel.text = SettingsBundleHelper.getBuild()
        soundOn.isOn = SettingsBundleHelper.getSoundOn()
        
    }
    
    @IBAction func soundOnChanged(_ sender: UISwitch) {
        SettingsBundleHelper.setSoundOn(enable: sender.isOn)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let header = view as? UITableViewHeaderFooterView {
////            header.contentView.backgroundColor = Constants.Colors.LightColor
////            header.textLabel?.textColor = Constants.Colors.SelectedColor
//        }
    }
    
    
    
}
