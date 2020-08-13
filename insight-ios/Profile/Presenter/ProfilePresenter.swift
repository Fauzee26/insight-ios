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
    private var delegate: ProfileDelegate!
    
    func setAvatarBgColor(_ color: String) {
        udService.userBgColor = color
    }
    
    func getAvatarName() -> String {
        return udService.userAvatarName
    }
    
    func setProfile(name: String, email: String, bgColor: String) {
        udService.userName = name
        udService.userEmail = email
        udService.userBgColor = bgColor
    }
    
    func getProfile() -> User {
        let name = udService.userName
        let email = udService.userEmail
        let avatar = udService.userAvatarName
        let color = udService.userBgColor
        
        return User(userName: name, userEmail: email, userAvatar: avatar, userBgColor: color)
    }
    
    func returnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a: NSString?
        
        r = scanner.scanUpToCharacters(from: comma) as NSString?
        g = scanner.scanUpToCharacters(from: comma) as NSString?
        b = scanner.scanUpToCharacters(from: comma) as NSString?
        a = scanner.scanUpToCharacters(from: comma) as NSString?
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return newUIColor
    }
    
    func updateProfile(email: String, fullname: String, bgColor: String, avatarName: String) {
        let record = NSKeyedUnarchiver.unarchiveObject(with: udService.recordId) as! CKRecord
        
        record.setValue(email, forKey: CKUserModel.emailKey)
        record.setValue(fullname, forKey: CKUserModel.fullnameKey)
        record.setValue(bgColor, forKey: CKUserModel.bgColorKey)
        record.setValue(avatarName, forKey: CKUserModel.avatarKey)
        
        let db = CKContainer.default().publicCloudDatabase
        db.save(record) { (record, error) in
            
            if let error = error {
                self.delegate.updateFailed(error: error)
            } else {
                do {
                    let data = try NSKeyedArchiver.archivedData(withRootObject: record!, requiringSecureCoding: true)
                    
                    self.udService.recordId = data
                    
                    self.delegate.updateSuccessfull()
                }  catch let error{
                    self.delegate.updateFailed(error: error)
                }
            }
        }
    }
}
