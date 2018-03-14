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
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var errorTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // Actions
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAcctPressed(_ sender: Any) {
        guard let username = usernameTxt.text , usernameTxt.text != "" else {
            errorTxt.isHidden = false
            return
        }
        guard let email = emailTxt.text , emailTxt.text != "" else {
            errorTxt.isHidden = false
            return
        }
        guard let pass = passTxt.text, passTxt.text != "" else {
            errorTxt.isHidden = false
            return
        }
        errorTxt.isHidden = true
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user")
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    

}
