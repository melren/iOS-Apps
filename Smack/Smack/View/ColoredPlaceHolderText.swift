//
//  ColoredPlaceHolderText.swift
//  Smack
//
//  Created by Melanie Ren on 12/5/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

@IBDesignable
class ColoredPlaceHolderText: UITextField {
    
    @IBInspectable var placeholderColor: UIColor = SMACK_PURPLE_PLACEHOLDER {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
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
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
    }
    
}
