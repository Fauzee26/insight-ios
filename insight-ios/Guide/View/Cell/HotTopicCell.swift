//
//  HotTopicCell.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 06/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import SDWebImage

class HotTopicCell: UICollectionViewCell {

    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func configureCell(guide: Guide) {
        imageVIew.layer.cornerRadius = 15
        
        label.text = guide.title
        
        imageVIew.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageVIew.sd_setImage(with: URL(string: guide.imgLink))
    }
}
