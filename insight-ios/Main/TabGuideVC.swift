//
//  TabGuideVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 05/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class TabGuideVC: UIViewController {

    @IBOutlet weak var collectionViewHotTopic: UICollectionView!
    @IBOutlet weak var tableViewForum: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewHotTopic.delegate = self
        collectionViewHotTopic.dataSource = self
        collectionViewHotTopic.register(UINib(nibName: "HotTopicCell", bundle: self.nibBundle), forCellWithReuseIdentifier: "hotTopicCell")
    }
    
    @IBAction func btnSeeAllHotTopicPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSeeAllForumQuestionPressed(_ sender: UIButton) {
        
    }
}

extension TabGuideVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotTopicCell", for: indexPath) as? HotTopicCell else {return UICollectionViewCell()}
        
        cell.configureCell(image: UIImage(named: "dummy")!, name: "Usability Test")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
            return CGSize(width: view.frame.width/1, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Guide", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailTopicVC") as! DetailTopicVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
