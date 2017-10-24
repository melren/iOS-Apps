//
//  BorderButton.swift
//  Swoosh
//
//  Created by Melanie Ren on 10/23/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
    }

    
}
