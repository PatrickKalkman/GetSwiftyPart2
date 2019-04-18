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
        static let NotificationTimeoutKey = "notificationTimeout"
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
        if let build = UserDefaults.standard.object(forKey: SettingsBundleKeys.BuildVersionKey) as? String {
            return build
        }
        return "0"
    }
    
    class func getSoundOn() -> Bool {
        if let soundOn = UserDefaults.standard.object(forKey: SettingsBundleKeys.SoundOn) as? Bool {
            return soundOn
        }
        return true
    }
    
    class func setSoundOn(enable: Bool) {
        Sound.enabled = enable
        UserDefaults.standard.set(enable, forKey: SettingsBundleKeys.SoundOn)
    }
    
    class func getNotificationTimeout() -> UInt {
        if let notificationTimeout = UserDefaults.standard.object(forKey: SettingsBundleKeys.NotificationTimeoutKey) as? UInt {
            return notificationTimeout
        }
        return 2
    }
    
    class func setNotificationTimeout(timeout: UInt) {
        UserDefaults.standard.set(timeout, forKey: SettingsBundleKeys.NotificationTimeoutKey)
    }
}
