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
    
    @IBOutlet weak var viewLearnMore: UIView!
    var guide: Guide?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgTopic.layer.cornerRadius = 10
        
        lblTitleTopic.text = guide?.title
        lblDescTopic.text = guide?.desc
        
        DispatchQueue.main.async {
            var data: Data?
            if let imgUrl = self.guide?.imgLink {
                let url = URL(string: imgUrl)
                data = try? Data(contentsOf: url!)
            }
           
            var image = UIImage(named: "profileDefault")
            image = UIImage(data: data!)
            self.imgTopic.image = image
            
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToSafari(_:)))
        viewLearnMore.addGestureRecognizer(tap)
    }
    
    @objc func goToSafari(_ sender: UITapGestureRecognizer) {
        if let link = guide?.supportedLink {
            self.presentSFSafariVC(for: link)
        }
    }
}
