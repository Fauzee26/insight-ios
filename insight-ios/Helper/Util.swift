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
