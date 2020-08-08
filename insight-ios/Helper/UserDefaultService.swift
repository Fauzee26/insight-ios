//
//  UserDefaultService.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 08/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

class UserDefaultService {
    static let instance = UserDefaultService()
    
    private let def = UserDefaults.standard
    
    fileprivate let hasLaunchedKey = "hasLaunchedKey"
    
    // User Data
    fileprivate let userNameKey = "userNameKey"
    fileprivate let userEmailKey = "emailKey"
    fileprivate let userAvatarNameKey = "userAvatarNameKey"
    fileprivate let userBgColorKey = "userBgColorKey"
    
    var hasLaunched: Bool {
        get {
            return def.bool(forKey: hasLaunchedKey)
        }
        set {
            def.set(newValue, forKey: hasLaunchedKey)
        }
    }
    
    
    //MARK: - User Profile Section
    var userName: String {
        get {
            return def.string(forKey: userNameKey) ?? ""
        }
        set {
            def.set(newValue, forKey: userNameKey)
        }
    }
    
    var userEmail: String {
        get {
            return def.string(forKey: userEmailKey) ?? ""
        }
        set {
            def.set(newValue, forKey: userEmailKey)
        }
    }
    
    var userAvatarName: String {
        get {
            return def.string(forKey: userAvatarNameKey) ?? "profileDefault"
        }
        set {
            def.set(newValue, forKey: userAvatarNameKey)
        }
    }
    
    var userBgColor: String {
        get {
            return def.string(forKey: userBgColorKey) ?? ""
        }
        set {
            def.set(newValue, forKey: userBgColorKey)
        }
    }
}
