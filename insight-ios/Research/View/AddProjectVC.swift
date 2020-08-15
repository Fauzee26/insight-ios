//
//  AddProjectVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 03/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import DTGradientButton

class AddProjectVC: UIViewController {
    
    @IBOutlet weak var projectNameField: UITextField!
    @IBOutlet weak var switchDueDate: UISwitch!
    @IBOutlet weak var pickerDueDate: UIDatePicker!
    @IBOutlet weak var btnCreate: UIButton!
    
    var isDueDate = true

    var datePicked = Date()
    let dateFormatter = DateFormatter()
    var strDate: Date?
    var presenter: AddProjectPresenter?
    
    var delegate: ProjectAddedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = AddProjectPresenter(delegate: self)
        self.navigationController?.addCustomBackButton(title: "Create Project")
        btnCreate.layer.cornerRadius = btnCreate.frame.height/2
        btnCreate.setGradientBackgroundColors([#colorLiteral(red: 0.01568627451, green: 0.8, blue: 0.6, alpha: 1), #colorLiteral(red: 0.1647058824, green: 0.6980392157, blue: 0.7333333333, alpha: 1)], direction: .toRight, for: .normal)
        
        setupTextField()
        pickerDueDate.datePickerMode = .date
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        strDate = pickerDueDate.date
        
    }
    
    func setupTextField() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hideKeyboard))
        
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        projectNameField.inputAccessoryView = toolbar
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func dueDatePickerChanged(_ sender: UIDatePicker) {
        hideKeyboard()
        
        strDate = sender.date
    }
    
    @IBAction func dueDateSwitchChanged(_ sender: UISwitch) {
        let onState = switchDueDate.isOn
        
        isDueDate = onState
        pickerDueDate.isHidden = !isDueDate
    }
    
    
    
    @IBAction func btnCreateClicked(_ sender: UIButton) {
        if projectNameField.text!.isEmpty {
            alert(forTitle: "Warning", andMessage: "project name cannot be empty")
            return
        }
        
        let model = "Mobile App Product"
        if !isDueDate {
            strDate = nil
        }
        
        if let name = projectNameField.text {
            presenter?.addProject(projectName: name, projectModel: model, projectDueDate: strDate)
        }
    }
    
}

extension AddProjectVC: AddProjectDelegate {
    func addProjectSuccess() {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.delegate?.refresh()
            }
        }
    }
    
    func addProjectFailed(error: Error) {
        alert(forTitle: "Error", andMessage: error.localizedDescription)
    }
}

protocol ProjectAddedDelegate {
    func refresh()
}
