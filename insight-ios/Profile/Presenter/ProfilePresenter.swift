//
//  ProfilePresenter.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 08/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

protocol ProfileDelegate {
    func updateSuccessfull()
    func updateFailed(error: Error)
}

class ProfilePresenter {
    private let udService = UserDefaultService.instance
    
    //    func setAvatarName(_ avatarName: String) {
    //        udService.userAvatarName = avatarName
    //    }
    var delegate: ProfileDelegate!
    
    func setAvatarBgColor(_ color: String) {
        udService.userBgColor = color
    }
    
    func getAvatarName() -> String {
        return udService.userAvatarName
    }
    
    func setProfile(name: String, email: String, bgColor: String, avatarName: String) {
        udService.userName = name
        udService.userEmail = email
        udService.userBgColor = bgColor
        udService.userAvatarName = avatarName
    }
    
    func getProfile() -> User {
        let name = udService.userName
        let email = udService.userEmail
        let avatar = udService.userAvatarName
        let color = udService.userBgColor
        
        return User(userName: name, userEmail: email, userAvatar: avatar, userBgColor: color)
    }
    
    func isEmailAvailable(email: String, completion: @escaping (_ isAvailable: Bool) -> ()) {
        let container: CKContainer = CKContainer.default()
        let publicDB: CKDatabase = container.publicCloudDatabase
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "UserData", predicate: predicate)
        
        publicDB.perform(query, inZoneWith: CKRecordZone.default().zoneID) { (arrayResults, error) in
            if let err = error {
                self.delegate.updateFailed(error: err)
                return
            }
            
            guard let results = arrayResults else {return}
            var recordCount = 0
            
            for record in results {
                if recordCount <= 1 {
                    let emailRecord = record[CKUserModel.emailKey] as? String
                    if emailRecord == email {
                        print("email is here")
                        completion(false)
                        recordCount += 1
                    }
                }
            }
            
            if recordCount == 0 {
                completion(true)
            }
            
        }
    }
    
    func updateProfile(email: String, fullname: String, bgColor: String, avatarName: String) {
        var record: CKRecord = CKRecord(recordType: CKUserModel.recordType)
        do {
            record = try NSKeyedUnarchiver.unarchivedObject(ofClass: CKRecord.self, from: udService.recordId)!
        } catch let error {
            print(error.localizedDescription)
        }
        
        record.setValue(email, forKey: CKUserModel.emailKey)
        record.setValue(fullname, forKey: CKUserModel.fullnameKey)
        record.setValue(bgColor, forKey: CKUserModel.bgColorKey)
        record.setValue(avatarName, forKey: CKUserModel.avatarKey)
        
        print(record.recordID)
        let db = CKContainer.default().publicCloudDatabase
        db.save(record) { (resRecord, error) in
            if let err = error {
                print("errUpdatingData: ", err)
                self.delegate.updateFailed(error: err)
            } else {
                do {
                    let data = try NSKeyedArchiver.archivedData(withRootObject: resRecord!, requiringSecureCoding: true)

                    self.udService.recordId = data
                    self.setProfile(name: fullname, email: email, bgColor: bgColor, avatarName: avatarName)
                    self.delegate.updateSuccessfull()
                }  catch let error {
                    self.delegate.updateFailed(error: error)
                }
            }
        }
    }
}
