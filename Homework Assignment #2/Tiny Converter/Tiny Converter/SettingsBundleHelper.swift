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
    
    class func checkAndExecuteSettings() {
        
//        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.Reset) {
//            UserDefaults.standard.set(false, forKey: SettingsBundleKeys.Reset)
//            let appDomain: String? = Bundle.main.bundleIdentifier
//            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
//            // reset userDefaults..
//            // CoreDatsaDataModel().deleteAllData()
//            // delete all other user data here..
//        }
    }
    
    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: SettingsBundleKeys.AppVersionKey)
        
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: SettingsBundleKeys.BuildVersionKey)
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

