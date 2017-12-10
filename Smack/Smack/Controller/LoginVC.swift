//
//  LoginVC.swift
//  Smack
//
//  Created by Melanie Ren on 11/29/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: ColoredPlaceHolderText!
    @IBOutlet weak var passTxt: ColoredPlaceHolderText!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAcctBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        errorMsg.isHidden = true
        guard let email = emailTxt.text, emailTxt.text != "" else {
            emptyFieldError()
            return }
        guard let pass = passTxt.text, passTxt.text != "" else {
            emptyFieldError()
            return }
    
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        MessageService.instance.findAllChannel(completion: { (success) in
                            
                        })
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            } else {
                self.authenticationError()
            }
        }
    }
    
    func emptyFieldError() {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        errorMsg.text = "The email and password fields cannot be empty, please supply valid credentials"
        errorMsg.isHidden = false
    }
    
    func authenticationError() {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        errorMsg.text = "The email or password provided is incorrect, please try again."
        errorMsg.isHidden = false
    }
    
    func setupView() {
        spinner.isHidden = true
    }
}
