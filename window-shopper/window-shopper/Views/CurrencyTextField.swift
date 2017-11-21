//
//  CurrencyTextField.swift
//  window-shopper
//
//  Created by Melanie Ren on 11/20/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

@IBDesignable
class CurrencyTextField: UITextField {
    
    //don't implement this if it's empty
    override func draw(_ rect: CGRect) {
        let size: CGFloat = 20 //defaults to double unless set otherwise
        let currencyLbl = UILabel(frame: CGRect(x: 5, y: (frame.size.height / 2 - size / 2), width: size, height: size))
        currencyLbl.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.8043664384)
        currencyLbl.textAlignment = .center
        currencyLbl.textColor = #colorLiteral(red: 0.244709086, green: 0.244709086, blue: 0.244709086, alpha: 1)
        currencyLbl.layer.cornerRadius = 5.0
        currencyLbl.clipsToBounds = true
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        //default but this is how you set it explicitly
        formatter.locale = .current
        
        currencyLbl.text = formatter.currencySymbol
        addSubview(currencyLbl)
    }
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    func customizeView() {
        backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.2541470462)
        layer.cornerRadius = 5.0
        textAlignment = .center
        font = UIFont(name: "Avenir", size: 16)
        
        clipsToBounds = true    //needs to be added after drawrect
        
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
            attributedPlaceholder = place
            textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}
