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
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AllTopicCell", bundle: self.nibBundle), forCellReuseIdentifier: "allTopicCell")
    }
}

extension ListTopicVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "allTopicCell", for: indexPath) as? AllTopicCell else {return UITableViewCell()}
        
        cell.configureCell(img: UIImage(named: "dummy")!, name: "Usability Test")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Guide", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailTopicVC") as! DetailTopicVC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
