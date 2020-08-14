//
//  CKUserModel.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 13/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import CloudKit

struct CKUserModel {
    static let recordType = "UserData"
    
    static let avatarKey = "userAvatar"
    static let bgColorKey = "userBackgroundColor"
    static let emailKey = "userEmail"
    static let fullnameKey = "userFullName"
    static let idKey = "userIdentifier"
    static let passwordKey = "userPassword"
    
    var record: CKRecord
    
    init(record: CKRecord) {
        self.record = record
    }
    
    init() {
        self.record = CKRecord(recordType: CKUserModel.recordType)
    }
    
    var password: String {
        get {
            return self.record.value(forKey: CKUserModel.passwordKey) as! String
        }
        set {
            self.record.setValue(newValue, forKey: CKUserModel.passwordKey)
        }
    }
    
    var fullname: String {
        get {
            return self.record.value(forKey: CKUserModel.fullnameKey) as! String
        }
        set {
            self.record.setValue(newValue, forKey: CKUserModel.fullnameKey)
        }
    }
    
    var email: String {
        get {
            return self.record.value(forKey: CKUserModel.emailKey) as! String
        }
        set {
            self.record.setValue(newValue, forKey: CKUserModel.emailKey)
        }
    }
    
    var id: String {
        get {
            return self.record.value(forKey: CKUserModel.idKey) as! String
        }
        set {
            self.record.setValue(newValue, forKey: CKUserModel.idKey)
        }
    }
    
    var avatar: String {
        get {
            return self.record.value(forKey: CKUserModel.avatarKey) as! String
        }
        set {
            self.record.setValue(newValue, forKey: CKUserModel.avatarKey)
        }
    }
    
    var bgColor: String {
        get {
            return self.record.value(forKey: CKUserModel.bgColorKey) as! String
        }
        set {
            self.record.setValue(newValue, forKey: CKUserModel.bgColorKey)
        }
    }
    
    
}
