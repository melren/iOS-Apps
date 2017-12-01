//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Melanie Ren on 11/30/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
