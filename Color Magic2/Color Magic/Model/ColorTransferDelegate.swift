//
//  ColorTransferDelegate.swift
//  Color Magic
//
//  Created by Melanie Ren on 11/5/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import Foundation
import UIKit

protocol ColorTransferDelegate {
    func userDidChoose(color: UIColor, withName colorName: String)
}

