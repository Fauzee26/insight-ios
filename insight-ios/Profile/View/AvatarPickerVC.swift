//
//  AvatarPickerVC.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 07/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var avatarType = AvatarType.light
    private let presenter = ProfilePresenter()
    
    var delegate: AvatarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            avatarType = .light
        } else {
            avatarType = .dark
        }
        
        collectionView.reloadData()
    }
}

extension AvatarPickerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell else {return UICollectionViewCell()}
        cell.configureCell(index: indexPath.item, type: avatarType)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numOfColumns = 4
        }
        
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        let cellDimensions = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        
        return CGSize(width: cellDimensions, height: cellDimensions)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var name = "light\(indexPath.item)"
        
        if avatarType == .dark {
            name = "dark\(indexPath.item)"
        }
        
        delegate?.avatarName(name: name)

        self.dismiss(animated: true, completion: nil)
    }
}

protocol AvatarDelegate {
    func avatarName(name: String)
}
