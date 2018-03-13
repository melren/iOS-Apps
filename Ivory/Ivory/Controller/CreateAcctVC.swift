//
//  CreateAcctVC.swift
//  Ivory
//
//  Created by Melanie Ren on 3/13/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import UIKit

class CreateAcctVC: UIViewController {

    // Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // Actions
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    

}
