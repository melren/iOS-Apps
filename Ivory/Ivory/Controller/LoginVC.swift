//
//  LoginVC.swift
//  Ivory
//
//  Created by Melanie Ren on 3/13/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var errorTxt: UILabel!
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Actions
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        errorTxt.isHidden = true
        spinner.startAnimating()
        guard let username = usernameTxt.text , usernameTxt.text != "" else {
            spinner.stopAnimating()
            return
        }
        guard let password = passwordTxt.text , passwordTxt.text != "" else {
            spinner.stopAnimating()
            return
        }
        
        AuthService.instance.loginUser(email: username, password: password) { ( response ) in
            if response == "" {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            } else {
                self.errorTxt.text = response
                self.errorTxt.isHidden = false
            }
            self.spinner.stopAnimating()
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAcctBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCT, sender: nil)
    }
    
}
