//
//  ViewController.swift
//  Eluxon
//
//  Created by Melanie Ren on 10/20/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var onOffLbl: UILabel!
    @IBOutlet weak var toggleBtn: UIButton!
    
    
    //set switch to be off by default
    var switchStatus: SwitchStatus = .off
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func toggleBtnPressed(_ sender: Any) {
        switchStatus.toggle()
        if switchStatus == .off {
            //set image to be off button
            //toggleBtn.setImage(UIImage(named:"powerButton")!, for: .normal)
            view.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
            onOffLbl.text = "🌚 OFF 🌚"
            onOffLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            //toggleBtn.setImage(UIImage(named: "powerButton")!, for: .normal)
            view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            onOffLbl.text = "🌝 ON 🌝"
            onOffLbl.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        }
    }
    
    
}

