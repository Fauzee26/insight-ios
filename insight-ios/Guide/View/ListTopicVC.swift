//
//  ListTopicVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 06/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class ListTopicVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var guides = [Guide]()
    var presenter: GuidePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = GuidePresenter(delegate: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AllTopicCell", bundle: self.nibBundle), forCellReuseIdentifier: "allTopicCell")
        
        presenter?.getAllData()
    }
}

extension ListTopicVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "allTopicCell", for: indexPath) as? AllTopicCell else {return UITableViewCell()}
        
        let guide = guides[indexPath.row]
        cell.configureCell(guide: guide)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Guide", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailTopicVC") as! DetailTopicVC
        vc.guide = guides[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListTopicVC: GuideDelegate {
    func dataGuideSuccess(arrayGuide: [Guide]) {
        guides = arrayGuide
        print("count: ", guides.count)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func dataGuideFailed(err: Error) {
        print("error hereeeee: ", err.localizedDescription)
    }
    
    
}
