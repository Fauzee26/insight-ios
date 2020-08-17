//
//  EditProfileVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 05/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import DTGradientButton

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    private var presenter = ProfilePresenter()
    private var user = User()
    private let udService = UserDefaultService.instance
    
    var bgColor: UIColor?
    var strBgColor: String?

    var avatarChosen = "profileDefault"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
        btnSave.layer.cornerRadius = btnSave.frame.height / 2
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        btnSave.setGradientBackgroundColors([#colorLiteral(red: 0.01568627451, green: 0.8, blue: 0.6, alpha: 1), #colorLiteral(red: 0.1647058824, green: 0.6980392157, blue: 0.7333333333, alpha: 1)], direction: .toRight, for: .normal)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(userAvatarDidChange(_:)), name: NOTIF_USER_AVATAR_DID_CHANGE, object: nil)
    }
    
    @IBAction func changeAvatarPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAvatarPicker", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAvatarPicker" {
            let avatarPickerVC = segue.destination as! AvatarPickerVC
            avatarPickerVC.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = presenter.getProfile()
        if user.userAvatar != "" {
            imgProfile.image = UIImage(named: user.userAvatar)
            avatarChosen = user.userAvatar
            if user.userBgColor != "" {
                imgProfile.backgroundColor = returnUIColor(components: user.userBgColor)
            } else if user.userAvatar.contains("light") && user.userBgColor == "" {
                imgProfile.backgroundColor = UIColor.lightGray
            }
        }
        
        fullNameField.text = user.userName
        emailField.text = user.userEmail
    }
    
    @IBAction func btnSavePressed(_ sender: Any) {
        if fullNameField.text!.isEmpty {
            alert("Full Name cannot be empty")
            return
        }
        
        if emailField.text!.isEmpty {
            alert("Email cannot be empty")
            return
        }
        
        let getBGColorRGBA = imgProfile.backgroundColor?.rgba
        let returnedRGBAString = "[\(getBGColorRGBA!.red), \(getBGColorRGBA!.green), \(getBGColorRGBA!.blue), \(getBGColorRGBA!.alpha)]"
        
        if let name = fullNameField.text, let email = emailField.text {
            view.endEditing(true)
            
            if udService.userEmail != email {
                presenter.isEmailAvailable(email: email) { (isAvailable) in
                    if isAvailable {
                        self.presenter.updateProfile(email: email, fullname: name, bgColor: returnedRGBAString, avatarName: self.avatarChosen)
                    } else {
                        DispatchQueue.main.async {
                            self.alert(forTitle: "Warning!", andMessage: "email already used, try another one!")
                        }
                    }
                }
            } else {
                self.presenter.updateProfile(email: email, fullname: name, bgColor: returnedRGBAString, avatarName: self.avatarChosen)
            }
            
        }
    }
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func userAvatarDidChange(_ notif: Notification) {
        imgProfile.image = UIImage(named: presenter.getAvatarName())
    }
    
    func alert(_ message: String){
        let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func generateBgColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        strBgColor = "[\(r), \(g), \(b), 1]"
        
        UIView.animate(withDuration: 0.2) {
            self.imgProfile.backgroundColor = self.bgColor
        }
    }
}

extension EditProfileVC: AvatarDelegate {
    func avatarName(name: String) {
        avatarChosen = name
        imgProfile.image = UIImage(named: avatarChosen)
    }
}

extension EditProfileVC: ProfileDelegate {
    func updateSuccessfull() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: NOTIF_USER_PROFILE_DID_CHANGE, object: nil)
        }
    }
    
    func updateFailed(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
