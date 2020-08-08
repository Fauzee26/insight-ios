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
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    private var presenter = ProfilePresenter()
    private var user = User()
    var bgColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()

        btnSave.layer.cornerRadius = btnSave.frame.height / 2
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        
        NotificationCenter.default.addObserver(self, selector: #selector(userAvatarDidChange(_:)), name: NOTIF_USER_AVATAR_DID_CHANGE, object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = presenter.getProfile()
        if user.userAvatar != "" {
            imgProfile.image = UIImage(named: user.userAvatar)
            
            if user.userAvatar.contains("light") && user.userBgColor == "" {
                imgProfile.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func btnSavePressed(_ sender: Any) {
        
    }
    
    @objc func userAvatarDidChange(_ notif: Notification) {
        imgProfile.image = UIImage(named: presenter.getAvatarName())
    }
    
    @IBAction func generateBgColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        presenter.setAvatarBgColor("[\(r), \(g), \(b), 1]")
        
        UIView.animate(withDuration: 0.2) {
            self.imgProfile.backgroundColor = self.bgColor
        }
    }
}
