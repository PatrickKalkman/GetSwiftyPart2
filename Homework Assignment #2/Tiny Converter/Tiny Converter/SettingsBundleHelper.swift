//
//  SettingsAndBundleHelper.swift
//  Tiny Converter
//
//  Created by Patrick Kalkman on 16/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class SettingsBundleHelper {

    struct SettingsBundleKeys {
        static let NumberOfDecimals = "numberOfDecimals"
        static let BuildVersionKey = "build"
        static let AppVersionKey = "version"
    }

    class func initialize() {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            UserDefaults.standard.set(version, forKey: SettingsBundleKeys.AppVersionKey)
        }

        if let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
            UserDefaults.standard.set(build, forKey: SettingsBundleKeys.BuildVersionKey)
        }
    }

    class func getVersion() -> String {
        return UserDefaults.standard.string(forKey: SettingsBundleKeys.AppVersionKey) ?? ""
    }

    class func getBuild() -> String {
        return UserDefaults.standard.string(forKey: SettingsBundleKeys.BuildVersionKey) ?? ""
    }

    class func getNumberOfDecimals() -> Int {
        return UserDefaults.standard.integer(forKey: SettingsBundleKeys.NumberOfDecimals)
    }

    class func setNumberOfDecimals(numberOfDecimals: Int) {
        UserDefaults.standard.set(numberOfDecimals, forKey: SettingsBundleKeys.NumberOfDecimals)
    }

}
