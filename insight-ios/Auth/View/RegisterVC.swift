//
//  RegisterVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 02/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import CloudKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    var presenter: RegisterPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RegisterPresenter(delegate: self)
        
        btnRegister.layer.cornerRadius = btnRegister.frame.height/2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func loginHereBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        if fullNameField.text!.isEmpty {
            alert(message: "fullname cannot be empty")
            return
        }
        
        if emailField.text!.isEmpty {
            alert(message: "email address cannot be empty")
            return
        }
        
        if passwordField.text!.isEmpty {
            alert(message: "password cannot be empty")
            return
        }
        
        if confirmPasswordField.text != passwordField.text {
            alert(message: "your confirmation password doesn't match")
            return
        }
        
        if let fullname = fullNameField.text, let email = emailField.text, let password = passwordField.text {
            showProgress()
            self.view.endEditing(true)
            presenter?.isEmailAvailable(email: emailField!.text!, completion: { (isAvailable) in
                if isAvailable {
                    self.presenter?.registerUser(fullname: fullname, email: email, id: UUID().uuidString, password: password)
                } else {
                    DispatchQueue.main.async {
                        self.alert(forTitle: "Warning!", andMessage: "email already used, try another one!")
                    }
                }
            })

        }
    }
    
    func alert(message: String){
        let alertController = UIAlertController(title: "Warning!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RegisterVC: RegisterDelegate {
    func registerSuccess(record: CKRecord) {
        hideProgress()
        let udService = UserDefaultService.instance
        
        udService.userEmail = record["userEmail"] as! String
        udService.userName = record["userFullName"] as! String
        udService.userId = record["userIdentifier"] as! String
        udService.userAvatarName = record["userAvatar"] as! String
        udService.userBgColor = record["userBackgroundColor"] as! String
        udService.isLoggedIn = true
        
        print("Successfully Registered")
        DispatchQueue.main.async {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let main = storyboard.instantiateInitialViewController() as! UITabBarController
            self.present(main, animated: true, completion: nil)
        }
    }
    
    func onError(_ error: Error) {
        alert(message: error.localizedDescription)
    }
    
    func registerFailed(error: Error) {
        hideProgress()
        
        DispatchQueue.main.async {
            self.alert(message: error.localizedDescription)
        }
    }
}
