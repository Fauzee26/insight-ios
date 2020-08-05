//
//  TabProfileVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 05/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class TabProfileVC: UIViewController {

    @IBOutlet weak var viewProfile: UIView!
    
//    var delegate: ViewClicked!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(goToEditProfile(_:)))
        viewProfile.addGestureRecognizer(tap)
    }
    
    @objc func goToEditProfile(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toEditProfile", sender: self)
    }
    
}
