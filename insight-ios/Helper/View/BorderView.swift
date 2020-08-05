//
//  BorderView.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 05/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

@IBDesignable
class BorderView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 8.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0.9294117647, green: 0.9411764706, blue: 0.9450980392, alpha: 1) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 2.0
    }
}
