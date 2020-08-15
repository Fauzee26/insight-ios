//
//  CKResearchModel.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 15/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import CloudKit

struct CKResearchModel {
    static let researchRecordType = "ResearchData"
    
    static let userIdKey = "userId"
    static let projectIdKey = "projectId"
    static let projectNameKey = "projectName"
    static let projectModelKey = "projectModel"
    static let projectTimeCreateKey = "projectTimeCreate"
    static let projectTimeDueKey = "projectTimeDue"
    
    var record: CKRecord
    
    init(record: CKRecord) {
        self.record = record
    }
    
    init() {
        self.record = CKRecord(recordType: CKResearchModel.researchRecordType)
    }
    
    var projectId: String {
        get {
            return self.record.value(forKey: CKResearchModel.projectIdKey) as! String
        }
        set {
            self.record.setValue(newValue, forKey: CKResearchModel.projectIdKey)
        }
    }
    
    var userId: String {
        get {
            return self.record.value(forKey: CKResearchModel.userIdKey) as! String
        }
        set {
            self.record.setValue(newValue, forKey: CKResearchModel.userIdKey)
        }
    }
    
    var projectName: String {
        get {
            return self.record.value(forKey: CKResearchModel.projectNameKey) as! String
        }
        set {
            self.record.setValue(newValue, forKey: CKResearchModel.projectNameKey)
        }
    }
    
    var projectModel: String {
        get {
            return self.record.value(forKey: CKResearchModel.projectModelKey) as! String
        }
        set {
            self.record.setValue(newValue, forKey: CKResearchModel.projectModelKey)
        }
    }
    
    var projectTimeCreate: Date {
        get {
            return self.record.value(forKey: CKResearchModel.projectTimeCreateKey) as! Date
        }
        set {
            self.record.setValue(newValue, forKey: CKResearchModel.projectTimeCreateKey)
        }
    }
    
    var projectTimeDue: Date? {
        get {
            return self.record.value(forKey: CKResearchModel.projectTimeDueKey) as? Date
        }
        set {
            self.record.setValue(newValue, forKey: CKResearchModel.projectTimeDueKey)
        }
    }
}
