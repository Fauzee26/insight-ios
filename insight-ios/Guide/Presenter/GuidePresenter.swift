//
//  GuidePresenter.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 14/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import CloudKit

protocol GuideDelegate {
    func dataGuideSuccess(arrayGuide: [Guide])
    func dataGuideFailed(err: Error)
}

class GuidePresenter {
    var delegate: GuideDelegate?
    var container: CKContainer
    let publicDB: CKDatabase
    
    init(delegate: GuideDelegate) {
        self.delegate = delegate
        
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
    }
    
    func getAllData() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: guideRecordType, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: CKRecordZone.default().zoneID) { (arrayResults, error) in
            if let err = error {
                self.delegate?.dataGuideFailed(err: err)
                return
            }
            
            guard let results = arrayResults else {return}
            
            var guides: [Guide] = [Guide]()
            for record in results {
                let guideTitle = record["title"] as! String
                let desc = record["description"] as! String
                let supportedLink = record["supportedLink"] as! String
                let imgUrl = record["imgUrl"] as! String
                
                let guide = Guide(title: guideTitle, desc: desc, imgLink: imgUrl, supportedLink: supportedLink)
                guides.append(guide)
            }
            
            self.delegate?.dataGuideSuccess(arrayGuide: guides)
        }
    }
}
