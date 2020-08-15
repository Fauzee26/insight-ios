//
//  AddProjectPresenter.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 15/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import CloudKit

protocol AddProjectDelegate {
    func addProjectSuccess()
    func addProjectFailed(error: Error)
}

class AddProjectPresenter {
    private let db = CKContainer.default().publicCloudDatabase
    private var delegate: AddProjectDelegate
    
    var records = [CKRecord]()
    var insertedObjects = [CKResearchModel]()
    
    init(delegate: AddProjectDelegate) {
        self.delegate = delegate
    }
    
    func addProject(projectName: String, projectModel: String, projectDueDate: Date?) {
        var project = CKResearchModel()
        
        let id = UserDefaultService.instance.userId
        
        project.projectId = UUID().uuidString
        project.projectModel = projectModel
        project.projectName = projectName
        project.projectTimeCreate = Date()
        project.userId = id

        if let dueDate = projectDueDate {
            project.projectTimeDue = dueDate
        }
        
        print("record here: ", project.record)
        db.save(project.record) { (record, error) in
            if let error = error {
                self.delegate.addProjectFailed(error: error)
            } else {
                print("success add project")
                self.delegate.addProjectSuccess()
            }
        }
    }
}
