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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add ability to dismiss keyboard on tap off
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAcctVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.gray
            }
        }
        spinner.isHidden = true
    }

    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func displayError() {
        errorTxt.text = "Fields cannot be left blank."
        errorTxt.isHidden = false
        spinner.stopAnimating()
    }
    
    // Actions
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAcctPressed(_ sender: Any) {
        spinner.startAnimating()
        guard let username = usernameTxt.text , usernameTxt.text != "" else {
            displayError()
            return
        }
        guard let email = emailTxt.text , emailTxt.text != "" else {
            displayError()
            return
        }
        guard let pass = passTxt.text, passTxt.text != "" else {
            displayError()
            return
        }
        errorTxt.isHidden = true
        AuthService.instance.registerUser(email: email, password: pass) { (completion) in
            if completion == "success" {
                self.errorTxt.isHidden = true
                
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            } else {
                self.spinner.stopAnimating()
                self.errorTxt.text = completion
                self.errorTxt.isHidden = false
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
    }

}
