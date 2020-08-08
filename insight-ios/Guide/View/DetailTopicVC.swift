//
//  DetailTopicVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 07/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class DetailTopicVC: UIViewController {

    @IBOutlet weak var lblTitleTopic: UILabel!
    @IBOutlet weak var imgTopic: UIImageView!
    @IBOutlet weak var lblDescTopic: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgTopic.layer.cornerRadius = 10
    }
}
