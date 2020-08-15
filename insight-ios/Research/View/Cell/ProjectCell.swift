//
//  ProjectCell.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 02/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var lblProjectType: UILabel!
    @IBOutlet weak var lblProjectCreateTime: UILabel!
    @IBOutlet weak var lblProjectFinishedEstimated: UILabel!
    @IBOutlet weak var imgProjectMember: UIImageView!
    @IBOutlet weak var imgAddMember: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgProjectMember.layer.cornerRadius = imgProjectMember.frame.height/2
        imgAddMember.layer.cornerRadius = imgAddMember.frame.height/2
        
    }
    
    func configureCell(project: CKResearchModel) {
        lblProjectName.text = project.projectName
        lblProjectType.text = project.projectModel
        
        imgProjectMember.image = UIImage(named: UserDefaultService.instance.userAvatarName)
        imgProjectMember.backgroundColor = returnUIColor(components: UserDefaultService.instance.userBgColor)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"
        
        let dateCreated = dateFormatterGet.date(from: String(describing: project.projectTimeCreate))
        
        lblProjectCreateTime.text = "Created on \(dateFormatterPrint.string(from: dateCreated!))"
        
        if let dateDue = project.projectTimeDue {
            let dateDueFormatted = dateFormatterGet.date(from: String(describing: dateDue))

            lblProjectFinishedEstimated.text = "Estimated Finished \(dateFormatterPrint.string(from: dateDueFormatted!))"
        } else {
            lblProjectFinishedEstimated.isHidden = true
        }
    }
}
