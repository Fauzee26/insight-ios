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
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtNameProfile: UILabel!
    @IBOutlet weak var txtEmailProfile: UILabel!
    @IBOutlet weak var rightBar: UIBarButtonItem!
    
    let udService = UserDefaultService.instance
    let presenter = ProfilePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2

        let tap = UITapGestureRecognizer(target: self, action: #selector(goToEditProfile(_:)))
        viewProfile.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupProfile), name: NOTIF_USER_PROFILE_DID_CHANGE, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupProfile()
        
        var title = "Logout"
        var color = UIColor.systemRed
        
        if udService.isLoggedIn == false {
            title = "Sign In"
            color = UIColor(named: "grey")!
        }
        
        rightBar.title = title
        rightBar.tintColor = color
    }
    
    @objc func setupProfile() {
        let user = presenter.getProfile()
        imgProfile.image = UIImage(named: user.userAvatar)
        imgProfile.backgroundColor = presenter.returnUIColor(components: user.userBgColor)
        
        txtNameProfile.text = udService.userName
        txtEmailProfile.text = udService.userEmail

//        txtNameProfile.text = user.userName == "" ? "-your name here-" : user.userName
//        txtEmailProfile.text = user.userEmail == "" ? "-email@email.com-" : user.userEmail
    }
    
    @objc func goToEditProfile(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toEditProfile", sender: self)
    }
   
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        udService.isLoggedIn = false
        udService.userName = ""
        udService.userEmail = ""
        udService.userId = ""
        
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let navAuth = storyboard.instantiateInitialViewController() as! UINavigationController
        present(navAuth, animated: true, completion: nil)
    }
    
}

