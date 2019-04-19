//
//  SettingsViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 14/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit
import Hero

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var soundOn: UISwitch!
    @IBOutlet weak var notificationTimeoutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.hero.id = "test"
        
        self.navigationItem.title = "Settings"
        let textAttributes = [NSAttributedString.Key.foregroundColor:Constants.Colors.DarkGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        versionLabel.text = SettingsBundleHelper.getVersion()
        buildLabel.text = SettingsBundleHelper.getBuild()
        soundOn.isOn = SettingsBundleHelper.getSoundOn()
        notificationTimeoutLabel.text = "\(SettingsBundleHelper.getNotificationTimeout())s"
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func soundOnChanged(_ sender: UISwitch) {
        SettingsBundleHelper.setSoundOn(enable: sender.isOn)
    }
    
    @IBAction func notificationTimeoutChanges(_ sender: UIStepper) {
        let notificationTimeout: UInt = UInt(sender.value)
        SettingsBundleHelper.setNotificationTimeout(timeout: notificationTimeout)
        notificationTimeoutLabel.text = "\(SettingsBundleHelper.getNotificationTimeout())s"
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let header = view as? UITableViewHeaderFooterView {
////            header.contentView.backgroundColor = Constants.Colors.LightColor
////            header.textLabel?.textColor = Constants.Colors.SelectedColor
//        }
    }
    
    
    
}
