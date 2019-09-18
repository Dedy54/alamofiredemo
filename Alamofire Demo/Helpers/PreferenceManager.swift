//
//  PreferenceManager.swift
//  The F Thing
//
//  Created by Chandra Welim on 12/4/17.
//  Copyright © 2017 MNC Innovation Center. All rights reserved.
//

import UIKit

class PreferenceManager: NSObject {
    
    private static let IsUserLogin = "is_user_login"
    
    static let instance = PreferenceManager()
    
    private let userDefaults: UserDefaults
    
    override init() {
        userDefaults = UserDefaults.standard
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    var isUserLogin: Bool? {
        get {
            return userDefaults.bool(forKey: PreferenceManager.IsUserLogin)
        }
        set(newValue) {
            if let value = newValue {
                userDefaults.set(value, forKey: PreferenceManager.IsUserLogin)
            } else {
                userDefaults.removeObject(forKey: PreferenceManager.IsUserLogin)
            }
        }
    }
    
}
