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
    
    var guides = [Guide]()
    var presenter: GuidePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = GuidePresenter(delegate: self)
        collectionViewHotTopic.delegate = self
        collectionViewHotTopic.dataSource = self
        collectionViewHotTopic.register(UINib(nibName: "HotTopicCell", bundle: self.nibBundle), forCellWithReuseIdentifier: "hotTopicCell")
        
        tableViewForum.setEmptyState(title: "Sorry :(", message: "This feature on development process 👷‍♂️")
        presenter?.getAllData()
    }
    
    @IBAction func btnSeeAllHotTopicPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSeeAllForumQuestionPressed(_ sender: UIButton) {
        
    }
}

extension TabGuideVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotTopicCell", for: indexPath) as? HotTopicCell else {return UICollectionViewCell()}
        
        let guide = guides[indexPath.row]
        cell.configureCell(guide: guide)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
            return CGSize(width: view.frame.width/1, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Guide", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailTopicVC") as! DetailTopicVC
        vc.guide = guides[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TabGuideVC: GuideDelegate {
    func dataGuideSuccess(arrayGuide: [Guide]) {
        var first3Guide = [Guide]()
        var count = 0
        if arrayGuide.count >= 3 {
            for g in arrayGuide {
                if count <= 2 {
                    first3Guide.append(g)
                    count += 1
                }
            }
        } else {
            first3Guide = arrayGuide
        }
        
        guides = first3Guide
        DispatchQueue.main.async {
            self.collectionViewHotTopic.reloadData()
        }
    }
    
    func dataGuideFailed(err: Error) {
        print("error tab research: ", err.localizedDescription)
    }
    
    
}
