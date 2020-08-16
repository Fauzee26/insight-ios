//
//  DetailStepVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 16/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class DetailStepVC: UIViewController {

    @IBOutlet weak var txtDesc: UILabel!
    var step: ProjectStep?
    var order: Int?
    var project: CKResearchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Step \(order! + 1)"
        self.navigationController?.addCustomBackButton(title: project!.projectName)
        
        txtDesc.text = step?.desc
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
