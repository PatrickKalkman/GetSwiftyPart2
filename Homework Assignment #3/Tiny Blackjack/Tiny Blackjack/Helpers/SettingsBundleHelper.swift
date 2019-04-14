//
//  SettingsBundleHelper.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 14/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftySound

class SettingsBundleHelper {
    
    struct SettingsBundleKeys {
        static let SoundOn = "soundOn"
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
        
        Sound.enabled = getSoundOn()
    }
    
    class func getVersion() -> String {
        return UserDefaults.standard.string(forKey: SettingsBundleKeys.AppVersionKey) ?? ""
    }
    
    class func getBuild() -> String {
        return UserDefaults.standard.string(forKey: SettingsBundleKeys.BuildVersionKey) ?? ""
    }
    
    class func getSoundOn() -> Bool {
       return UserDefaults.standard.bool(forKey: SettingsBundleKeys.SoundOn)
    }
    
    class func setSoundOn(enable: Bool) {
        Sound.enabled = enable
        UserDefaults.standard.set(enable, forKey: SettingsBundleKeys.SoundOn)
    }
    
}
