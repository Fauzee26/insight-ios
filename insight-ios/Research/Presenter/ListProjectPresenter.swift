//
//  ListProjectPresenter.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 15/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import CloudKit

protocol ListProjectDelegate {
    func dataProjectSuccess(projects: [CKResearchModel])
    func dataProjectFail(error: Error)
}

class ListProjectPresenter {
    var delegate: ListProjectDelegate?
    var container: CKContainer
    let publicDB: CKDatabase
    
    init(delegate: ListProjectDelegate) {
        self.delegate = delegate
        
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
    }
    
    func getAllData() {
        let id = UserDefaultService.instance.userId
        let predicate = NSPredicate(format: "userId == %@", id)
        
        let query = CKQuery(recordType: CKResearchModel.researchRecordType, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: CKResearchModel.projectTimeCreateKey, ascending: true)]
        
        publicDB.perform(query, inZoneWith: CKRecordZone.default().zoneID) { (arrayResults, error) in
            if let err = error {
                self.delegate?.dataProjectFail(error: err)
                return
            }
            
            guard let results = arrayResults else {return}
            
            var projects = [CKResearchModel]()
            for record in results {
                let project = CKResearchModel(record: record)
                projects.append(project)
            }
            
            self.delegate?.dataProjectSuccess(projects: projects)
        }
    }
}
