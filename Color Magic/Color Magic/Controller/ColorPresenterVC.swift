//
//  ColorPresenterVC.swift
//  Color Magic
//
//  Created by Melanie Ren on 10/20/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class ColorPresenterVC: UIViewController {
    
    var color = ColorPicker()
    
    @IBOutlet weak var colorNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func unwindFromColorPickerVC(unwindSegue: UIStoryboardSegue) {
        self.view.backgroundColor = color.colorOptions[color.background]
        colorNameLbl.text = "\(color.background!) is pretty!\n Choose another color?"
    }

}

