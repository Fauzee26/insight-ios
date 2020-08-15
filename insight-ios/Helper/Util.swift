//
//  Util.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 13/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

extension UIViewController {
    private struct activityAlert {
        static var alert: UIAlertController = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    }
    
    public func showProgress() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        activityAlert.alert.view.addSubview(loadingIndicator)
        activityAlert.alert.show(self, sender: nil)
    }
    
    public func hideProgress() {
        activityAlert.alert.dismiss(animated: true, completion: nil)
    }
    
    func alert(forTitle title: String, andMessage message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

extension UINavigationController {
    func addCustomBackButton(title: String = "Back") {
        let backButton = UIBarButtonItem()
        backButton.title = title
        navigationBar.topItem?.backBarButtonItem = backButton
    }
}

extension UITableView {
    func setEmptyState(title: String, message: String) {
        let label1 = UILabel()
        label1.textAlignment = .center
        label1.numberOfLines = 0
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: label1.font.fontName, size: 20)]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: label1.font.fontName, size: 16)]
        
        let attributedString1 = NSMutableAttributedString(string:title, attributes:attrs1 as [NSAttributedString.Key : Any])
        let attributedString2 = NSMutableAttributedString(string:"\n\(message)", attributes:attrs2 as [NSAttributedString.Key : Any])
        
        attributedString1.append(attributedString2)
        label1.attributedText = attributedString1
        
        let stackEmpty = UIStackView(frame: CGRect(x: self.bounds.size.width, y: self.bounds.size.height, width: self.bounds.size.width, height: 65.0))
        stackEmpty.axis = .vertical
        stackEmpty.alignment = .fill
        stackEmpty.distribution = .fill
        stackEmpty.spacing = 0.0
        stackEmpty.backgroundColor = .cyan
        
        stackEmpty.addArrangedSubview(label1)
        
        self.backgroundView = stackEmpty
    }
    
    func restore() {
        self.backgroundView = nil
    }
}


func returnUIColor(components: String) -> UIColor {
    let scanner = Scanner(string: components)
    let skipped = CharacterSet(charactersIn: "[], ")
    let comma = CharacterSet(charactersIn: ",")
    scanner.charactersToBeSkipped = skipped
    
    var r, g, b, a: NSString?
    
    r = scanner.scanUpToCharacters(from: comma) as NSString?
    g = scanner.scanUpToCharacters(from: comma) as NSString?
    b = scanner.scanUpToCharacters(from: comma) as NSString?
    a = scanner.scanUpToCharacters(from: comma) as NSString?
    
    let defaultColor = UIColor.lightGray
    
    guard let rUnwrapped = r else {return defaultColor}
    guard let gUnwrapped = g else {return defaultColor}
    guard let bUnwrapped = b else {return defaultColor}
    guard let aUnwrapped = a else {return defaultColor}
    
    let rFloat = CGFloat(rUnwrapped.doubleValue)
    let gFloat = CGFloat(gUnwrapped.doubleValue)
    let bFloat = CGFloat(bUnwrapped.doubleValue)
    let aFloat = CGFloat(aUnwrapped.doubleValue)
    
    let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
    
    return newUIColor
}

