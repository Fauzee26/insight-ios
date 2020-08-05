//
//  EditProfileVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 05/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var btnSave: GradientButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSave.layer.cornerRadius = btnSave.frame.height / 2
    }
    
    @IBAction func btnSavePressed(_ sender: Any) {
        print("tesss")
    }
}
