//
//  ChatInputText.swift
//  Ivory
//
//  Created by Melanie Ren on 3/20/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import UIKit

@IBDesignable
class ChatInputText: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 45);
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    @IBInspectable var placeholderColor: UIColor = IVORY_PLACEHOLDER {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
        self.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        self.layer.borderWidth = 1.0
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: (bounds.origin.x + bounds.width/2 - 45), y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
}
