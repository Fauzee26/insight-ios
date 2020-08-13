//
//  LoginVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 02/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var stackAppleId: UIStackView!
    
    let udService = UserDefaultService.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = btnLogin.frame.height/2
        
        setupTextField()
        
        let btnAppleId = ASAuthorizationAppleIDButton()
        btnAppleId.constraints.forEach { (constraint) in
            if (constraint.firstAttribute == .height) {
                constraint.isActive = false
            }
        }
        
        btnAppleId.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        btnAppleId.addTarget(self, action: #selector(handleLoginWithAppleId), for: .touchUpInside)
        stackAppleId.addArrangedSubview(btnAppleId)
    }
    
    func setupTextField() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hideKeyboard))
        
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        emailField.inputAccessoryView = toolbar
        passwordField.inputAccessoryView = toolbar
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if udService.isLoggedIn == true {
            goToMain()
        }
    }
    
    @objc func handleLoginWithAppleId() {
        let requests = [ASAuthorizationAppleIDProvider().createRequest(), ASAuthorizationPasswordProvider().createRequest()]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        if emailField.text!.isEmpty {
            alert(forTitle: "Warning!", andMessage: "Email cannot be empty")
            return
        }
        
        if passwordField.text!.isEmpty {
            alert(forTitle: "Warning!", andMessage: "Password cannot be empty")
            return
        }
    }
    
    @IBAction func loginLaterPressed(_ sender: UIButton) {
        goToMain()
    }
    
    func goToMain() {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let main = storyboard.instantiateInitialViewController() as! UITabBarController
        present(main, animated: true, completion: nil)
    }
}

extension LoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    print("apple id authorized: ", userIdentifier)
                    
                    print("email: \(email), name: \(fullName?.givenName) \(fullName?.familyName)")
                    DispatchQueue.main.async {
                        self.udService.userEmail = email ?? ""
                        self.udService.userName = "\(String(describing: fullName?.givenName)) \(String(describing: fullName?.familyName))"
                        self.udService.userId = userIdentifier
                        self.udService.isLoggedIn = true
                        
                        self.goToMain()
                    }
                    
                    
                    break
                case .revoked:
                    print("apple id revoked")
                    break
                case .notFound:
                    print("apple id not found")
                    break
                default:
                    break
                    
                }
            }
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            
            print("username: \(username), password: \(password)")
            //Navigate to other view controller
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //        alert(for: "Sign In Failed", and: error.localizedDescription)
    }
    
    func alert(forTitle title: String, andMessage message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
