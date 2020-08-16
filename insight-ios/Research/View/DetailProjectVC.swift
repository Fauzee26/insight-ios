//
//  DetailProjectVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 16/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class DetailProjectVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var imgMember: UIImageView!
    @IBOutlet weak var imgAddMember: UIImageView!
    @IBOutlet weak var lblDateCreate: UILabel!
    @IBOutlet weak var lblEstimationFinished: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var project: CKResearchModel?
    let udService = UserDefaultService.instance
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StepCell", bundle: self.nibBundle), forCellReuseIdentifier: "stepCell")
        
        lblName.text = project?.projectName
        lblModel.text = project?.projectModel
        
        imgMember.layer.cornerRadius = imgMember.frame.height/2
        imgAddMember.layer.cornerRadius = imgAddMember.frame.height/2
        
        imgMember.image = UIImage(named: udService.userAvatarName)
        imgMember.backgroundColor = returnUIColor(components: udService.userBgColor)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"
        
        let dateCreated = dateFormatterGet.date(from: String(describing: project!.projectTimeCreate))
        lblDateCreate.text = "Created on \(dateFormatterPrint.string(from: dateCreated!))"
        
        if let dateDue = project?.projectTimeDue {
            let dateDueFormatted = dateFormatterGet.date(from: String(describing: dateDue))

            lblEstimationFinished.text = "Estimated Finished \(dateFormatterPrint.string(from: dateDueFormatted!))"
        } else {
            lblEstimationFinished.isHidden = true
        }
        
        if !udService.notShowAgain {
            alert()
        }
    }
    
    func alert() {
        let alertController = UIAlertController(title: "Disclaimer", message: "This upcoming screen still in development, so you can't make much changes soon", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Understand", style: .default, handler: nil)
        
        let actionNegative = UIAlertAction(title: "Don't show again", style: .destructive) { (action) in
            self.udService.notShowAgain = true
        }
        
        alertController.addAction(alertAction)
        alertController.addAction(actionNegative)
        self.present(alertController, animated: true)
    }
}

extension DetailProjectVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getProjectStep.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell") as? StepCell else {return UITableViewCell()}
        
        let step = getProjectStep[indexPath.row]
        cell.configureCell(step: step, order: indexPath.row + 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Research", bundle: nil)
        let detailStepVC = storyboard.instantiateViewController(identifier: "DetailStepVC") as! DetailStepVC
        detailStepVC.order = indexPath.row
        detailStepVC.project = project
        detailStepVC.step = getProjectStep[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(detailStepVC, animated: true)
    }
}
