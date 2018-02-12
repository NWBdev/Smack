//
//  RoundedButton.swift
//  Smack
//
//  Created by Nathaniel Burciaga on 2/11/18.
//  Copyright © 2018 Nathaniel Burciaga. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    //setup the cornerRadius to the UIButton
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
}
