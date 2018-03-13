//
//  ColoredPlaceHolderText.swift
//  Ivory
//
//  Created by Melanie Ren on 3/13/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import UIKit

@IBDesignable
class ColoredPlaceHolderText: UITextField {
    
    @IBInspectable var placeholderColor: UIColor = IVORY_PLACEHOLDER {
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
