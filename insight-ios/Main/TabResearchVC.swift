//
//  ListProjectVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 03/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class TabResearchVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var arrayProjects = [CKResearchModel]()
    let udService = UserDefaultService.instance
    var presenter: ListProjectPresenter?
    @IBOutlet weak var btnSort: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ListProjectPresenter(delegate: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProjectCell", bundle: self.nibBundle), forCellReuseIdentifier: "projectCell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        if !udService.isLoggedIn {
            btnSort.isEnabled = false
            btnSort.tintColor = UIColor.clear
        }
            
        refreshData()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NOTIF_NEW_RESEARCH_DATA_ADDED, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    @objc func refreshData() {
        if UserDefaultService.instance.isLoggedIn {
//            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
                self.presenter?.getAllData()
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
//            }
        } else {
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            tableView.setEmptyState(title: "", message: "Please Login to see your project(s)")
        }
    }
    
    @IBAction func addNewProjectPressed(_ sender: UIBarButtonItem) {
        if udService.isLoggedIn {
            let storyboard = UIStoryboard(name: "Research", bundle: nil)
            let addResearchVC = storyboard.instantiateInitialViewController() as! AddProjectVC
            self.navigationController?.pushViewController(addResearchVC, animated: true)
        } else {
            alert(forTitle: "Warning", andMessage: "you need to login first to add new project")
        }
    }
    
    @IBAction func btnSortPressed(_ sender: UIBarButtonItem) {
        if udService.isLoggedIn {
            alert(forTitle: "Sorry", andMessage: "this feature not available yet")
        } else {
            alert(forTitle: "Warning", andMessage: "you need to login to use this feature")
        }
    }
}

extension TabResearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayProjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as? ProjectCell else {return UITableViewCell()}
        
        let project = arrayProjects[indexPath.row]
        cell.configureCell(project: project)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgAlert(sender:)))
        cell.imgAddMember.addGestureRecognizer(tap)
        
        return cell
    }
    
    @objc func imgAlert(sender: UITapGestureRecognizer) {
        alert(forTitle: "Hello", andMessage: "This feature not availabel yet :(")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Research", bundle: nil)
        let detailProjectVC = storyboard.instantiateViewController(identifier: "DetailProjectVC") as! DetailProjectVC
        
        let project = arrayProjects[indexPath.row]
        detailProjectVC.project = project
        
        self.navigationController?.pushViewController(detailProjectVC, animated: true)
    }
}

extension TabResearchVC: ListProjectDelegate {
    func dataProjectSuccess(projects: [CKResearchModel]) {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            self.arrayProjects.removeAll()
            self.arrayProjects = projects
            print(self.arrayProjects.count)
            self.tableView.reloadData()
            
            if self.arrayProjects.count == 0 {
                self.tableView.setEmptyState(title: "No Project(s) yet", message: "Add new one to be shown here")
            } else {
                self.tableView.restore()
            }
        }
    }
    
    func dataProjectFail(error: Error) {
        tableView.refreshControl?.endRefreshing()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
        alert(forTitle: "Error", andMessage: error.localizedDescription)
    }
}
