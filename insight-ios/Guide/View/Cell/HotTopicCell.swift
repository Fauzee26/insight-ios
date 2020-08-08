//
//  HotTopicCell.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 06/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class HotTopicCell: UICollectionViewCell {

    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func configureCell(image: UIImage, name: String) {
        imageVIew.layer.cornerRadius = 15
        imageVIew.image = image
        label.text = name
    }
}
