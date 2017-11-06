//
//  ColorPickerVC.swift
//  Color Magic
//
//  Created by Melanie Ren on 10/20/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class ColorPickerVC: UIViewController {

    var color = ColorPicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func colorBtnWasPressed(sender: UIButton) {
        color.background = sender.titleLabel?.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ColorPresenterVC = segue.destination as? ColorPresenterVC {
            ColorPresenterVC.color = color
        }
    }
}

