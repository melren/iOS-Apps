//
//  ColorPickerVC.swift
//  Color Magic
//
//  Created by Melanie Ren on 10/20/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class ColorPickerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func colorBtnWasPressed(sender: UIButton) {
        print(sender.titleLabel?.text!)
    }
}
