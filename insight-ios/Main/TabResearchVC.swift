//
//  ListProjectVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 03/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class TabResearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let udService = UserDefaultService.instance
//        if udService.isLoggedIn == false {
//            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
//            let navAuth = storyboard.instantiateInitialViewController() as! UINavigationController
//            let loginVC = navAuth.topViewController as! LoginVC
//            let nav = UINavigationController(rootViewController: loginVC)
//            present(nav, animated: true, completion: nil)
//        }
    }
    
    @IBAction func addNewProjectPressed(_ sender: UIBarButtonItem) {
        
    }

}
