//
//  LoginPresenter.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 13/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import CloudKit

protocol LoginDelegate {
    func loginSuccess(record: CKRecord)
    func loginFailed(_ error: String)
}

class LoginPresenter {
    
    var delegate: LoginDelegate
    var container: CKContainer
    let publicDB: CKDatabase
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
        
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
    }
    
    func login(userId: String) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "UserData", predicate: predicate)
        
        publicDB.perform(query, inZoneWith: CKRecordZone.default().zoneID) { (arrayResults, error) in
            if let err = error {
                self.delegate.loginFailed(err.localizedDescription)
                return
            }
            
            guard let results = arrayResults else {return}
            var recordCount = 0
            
            for record in results {
                if recordCount <= 1 {
                    let idRecord = record["userIdentifier"] as? String
                    if idRecord == userId {
                        print("ID is here")
                        self.delegate.loginSuccess(record: record)
                        recordCount += 1
                    }
                }
            }
            
            if recordCount == 0 {
                self.delegate.loginFailed("No id found on server")
            }
            
        }
    }
    
    func login(email: String, password: String) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "UserData", predicate: predicate)
        
        publicDB.perform(query, inZoneWith: CKRecordZone.default().zoneID) { (arrayResults, error) in
            if let err = error {
                self.delegate.loginFailed(err.localizedDescription)
                return
            }
            
            guard let results = arrayResults else {return}
            var recordCount = 0
            
            for record in results {
                if recordCount <= 1 {
                    let emailRecord = record["userEmail"] as? String
                    if emailRecord == email {
                        print("Email is here")
                        let passRecord = record["userPassword"] as? String
                        if passRecord == password {
                            print("password is match")
                            self.delegate.loginSuccess(record: record)
                            return
                        } else {
                            self.delegate.loginFailed("Password is wrong")
                        }
                        
                        recordCount += 1
                    }
                }
            }
            
            if recordCount == 0 {
                self.delegate.loginFailed("No email found on server")
            }
        }
    }
}
