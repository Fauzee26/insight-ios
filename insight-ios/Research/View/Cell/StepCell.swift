//
//  StepCell.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 16/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class StepCell: UITableViewCell {
    
    @IBOutlet weak var lblOrder: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDateStatus: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    
    func configureCell(step: ProjectStep, order: Int) {
        lblOrder.text = "Step \(order)"
        lblDesc.text = step.desc
        
        if step.status == .todo {
            imgStatus.image = UIImage(systemName: "chevron.right")
            lblStatus.text = "To Do"
        } else if step.status == .doing {
            imgStatus.image = UIImage(systemName: "square.and.pencil")
            lblStatus.text = "Doing"
        } else if step.status == .done {
            imgStatus.image = UIImage(systemName: "checkmark")
            lblStatus.text = "Done"
        }
        
        if let dueTime = step.dueDate {
            if step.status == .todo || step.status == .doing {
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
                
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "dd MMMM yyyy"
                
                let dueDate = dateFormatterGet.date(from: String(describing: dueTime))
                lblDateStatus.text = "DUE ON \(dateFormatterPrint.string(from: dueDate!))"
                
            }
        } else {
            if step.status == .done {
                lblDateStatus.text = "THIS STEP HAS COMPLETED!"
            } else {
                lblDateStatus.isHidden = true
            }
        }
    }
    
}
