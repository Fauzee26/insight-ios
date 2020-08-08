//
//  AllTopicCell.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 06/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class AllTopicCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    func configureCell(img: UIImage, name: String) {
        imgView.layer.cornerRadius = 10
        imgView.image = img
        labelName.text = name
    }
}
