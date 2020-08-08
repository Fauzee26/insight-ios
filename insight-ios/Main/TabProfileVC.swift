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
    
//    var delegate: ViewClicked!
    
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
    }
    
    @objc func setupProfile() {
        let user = presenter.getProfile()
        imgProfile.image = UIImage(named: user.userAvatar)
        imgProfile.backgroundColor = presenter.returnUIColor(components: user.userBgColor)
        
        txtNameProfile.text = user.userName == "" ? "-your name here-" : user.userName
        txtEmailProfile.text = user.userEmail == "" ? "-email@email.com-" : user.userEmail
    }
    
    @objc func goToEditProfile(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toEditProfile", sender: self)
    }
    
}
