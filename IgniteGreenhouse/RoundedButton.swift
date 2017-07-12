//
//  RoundedButton.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 12/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = cornerRadius
    }
    
}
