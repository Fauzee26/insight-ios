//
//  RegisterPresenter.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 13/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import CloudKit

protocol RegisterDelegate {
    func onError(_ error: Error)
    
    func registerSuccess(record: CKRecord)
    func registerFailed(error: Error)
}
class RegisterPresenter {
    
    private let db = CKContainer.default().publicCloudDatabase
    private var delegate: RegisterDelegate
    
    var records = [CKRecord]()
    var insertedObjects = [CKUserModel]()
    var deletedObjectIds = Set<CKRecord.ID>()
    
    var notificationQueue = OperationQueue.main
    
    //    var user = [User]() {
    //        didSet {
    //            self.notificationQueue.addOperation {
    //                self.delegate.onChange()
    //            }
    //        }
    //    }
    //
    init(delegate: RegisterDelegate) {
        self.delegate = delegate
    }
    
    private func handle(error: Error) {
        self.notificationQueue.addOperation {
            self.delegate.onError(error)
        }
    }
    
    func registerUser(fullname: String, email: String, id: String, password: String) {
        var user = CKUserModel()
        
        user.id = id
        user.email = email
        user.fullname = fullname
        user.avatar = "profileDefault"
        user.bgColor = "[0.5, 0.5, 0.5, 1]"
        user.password = password
        
        db.save(user.record) { (record, error) in
            if let error = error {
                self.handle(error: error)
                self.delegate.registerFailed(error: error)
            } else {
                do {
                    let data = try NSKeyedArchiver.archivedData(withRootObject: record!, requiringSecureCoding: true)
                    UserDefaultService.instance.recordId = data
                    
                    self.delegate.registerSuccess(record: record!)
                    
                } catch let error {
                    self.delegate.registerFailed(error: error)
                }
            }
        }
    }
    
    
}
