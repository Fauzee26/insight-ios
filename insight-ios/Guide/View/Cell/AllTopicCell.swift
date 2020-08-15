//
//  AllTopicCell.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 06/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import SDWebImage

class AllTopicCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    func configureCell(guide: Guide) {
        imgView.layer.cornerRadius = 10
        
        labelName.text = guide.title
        
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgView.sd_setImage(with: URL(string: guide.imgLink))
    }
}
