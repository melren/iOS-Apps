//
//  LoginVC.swift
//  Ivory
//
//  Created by Melanie Ren on 3/13/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // Actions
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAcctBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCT, sender: nil)
    }
    
}
