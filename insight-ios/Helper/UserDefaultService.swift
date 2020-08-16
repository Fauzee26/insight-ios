//
//  UserDefaultService.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 08/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import CloudKit

class UserDefaultService {
    static let instance = UserDefaultService()
    
    private let def = UserDefaults.standard
    
    fileprivate let hasLaunchedKey = "hasLaunchedKey"
    fileprivate let isLoggedInKey = "isLoggedInKey"
    
    // User Data
    fileprivate let userNameKey = "userNameKey"
    fileprivate let userEmailKey = "emailKey"
    fileprivate let userAvatarNameKey = "userAvatarNameKey"
    fileprivate let userBgColorKey = "userBgColorKey"
    fileprivate let userIdKey = "userIdKey"
    
    fileprivate let recordIdKey = "recordIdKey"
    
    fileprivate let notShowAgainKey = "notShowAgainKey"
    
    var hasLaunched: Bool {
        get {
            return def.bool(forKey: hasLaunchedKey)
        }
        set {
            def.set(newValue, forKey: hasLaunchedKey)
        }
    }
    
    var notShowAgain: Bool {
        get {
            return def.bool(forKey: notShowAgainKey)
        }
        set {
            def.set(newValue, forKey: notShowAgainKey)
        }
    }
    
    var recordId: Data {
        get {
            return def.data(forKey: recordIdKey) ?? Data()
        }
        set {
            def.set(newValue, forKey: recordIdKey)
        }
    }
    
    //MARK: - User Profile Section
    var userId: String {
        get {
            return def.string(forKey: userIdKey) ?? ""
        }
        set {
            def.set(newValue, forKey: userIdKey)
        }
    }
    
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
            return def.string(forKey: userBgColorKey) ?? "[0.5, 0.5, 0.5, 1]"
        }
        set {
            def.set(newValue, forKey: userBgColorKey)
        }
    }
    
    var isLoggedIn: Bool {
        get {
            return def.bool(forKey: isLoggedInKey)
        }
        set {
            def.set(newValue, forKey: isLoggedInKey)
        }
    }
}
