//
//  EmbeddedTableViewController.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 16/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

// TableViewController used to show settings
// The controller is embedded in the
class EmbeddedTableViewController: UITableViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var numberOfDecimalsLabel: UILabel!
    @IBOutlet weak var numberOfDecimalStepper: UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()

        versionLabel.text = SettingsBundleHelper.getVersion()
        buildLabel.text = SettingsBundleHelper.getBuild()
        let numberOfDecimals = SettingsBundleHelper.getNumberOfDecimals()
        numberOfDecimalStepper.value = Double(numberOfDecimals)
        numberOfDecimalsLabel.text = String(numberOfDecimals)
    }

    @IBAction func numberOfDecimalsValueChanges(_ sender: UIStepper) {
        let numberOfDecimals: Int = Int(sender.value)
        SettingsBundleHelper.setNumberOfDecimals(numberOfDecimals: numberOfDecimals)
        numberOfDecimalsLabel.text = numberOfDecimals.description
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = Constants.Colors.LightColor
            header.textLabel?.textColor = Constants.Colors.SelectedColor
        }
    }
}
