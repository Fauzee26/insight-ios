//
//  LoginVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 02/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import AuthenticationServices
import CloudKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var stackAppleId: UIStackView!
    
    let udService = UserDefaultService.instance
    var presenter: LoginPresenter?
    var registerPresenter: RegisterPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(delegate: self)
        registerPresenter = RegisterPresenter(delegate: self)
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
        let requests = ASAuthorizationAppleIDProvider().createRequest()
        requests.requestedScopes = [.email, .fullName]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [requests])
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
        
        if let email = emailField.text, let pass = passwordField.text {
            self.presenter?.login(email: email, password: pass)
            view.endEditing(true)
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
                    
                    DispatchQueue.main.async {
                        var firstName = ""
                        var lastName = ""
                        
                        if let givenName = fullName?.givenName, let familyName = fullName?.familyName {
                            firstName = givenName
                            lastName = familyName
                        }
                        
                        var nameCombination = ""
                        if firstName != "" {
                            nameCombination = firstName
                            if lastName != "" {
                                nameCombination = "\(firstName) \(lastName)"
                            }
                        }
                        
                        if email != nil {
                            self.registerPresenter?.registerUser(fullname: nameCombination, email: email!, id: userIdentifier, password: email!)
                        } else {
                            self.presenter?.login(userId: userIdentifier)
                        }
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
    
}

extension LoginVC: LoginDelegate {
    func loginSuccess(record: CKRecord) {
        print("Login Successful")
        
        udService.userEmail = record["userEmail"] as! String
        udService.userName = record["userFullName"] as! String
        udService.userId = record["userIdentifier"] as! String
        udService.userAvatarName = record["userAvatar"] as! String
        udService.userBgColor = record["userBackgroundColor"] as! String
        udService.isLoggedIn = true
        
        DispatchQueue.main.async {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let main = storyboard.instantiateInitialViewController() as! UITabBarController
            self.present(main, animated: true, completion: nil)
        }
    }
    
    func loginFailed(_ error: String) {
        print(error)
        DispatchQueue.main.async {
            self.alert(forTitle: "Warning", andMessage: error)
        }
    }
    
    
}

extension LoginVC: RegisterDelegate {
    func onError(_ error: Error) {
        DispatchQueue.main.async {
            self.alert(forTitle: "Warning", andMessage: error.localizedDescription)
        }
    }
    
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
    
    func registerFailed(error: Error) {
        DispatchQueue.main.async {
            self.alert(forTitle: "Warning", andMessage: error.localizedDescription)
        }
    }
    
    
}
