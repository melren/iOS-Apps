//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Melanie Ren on 11/30/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var accntErrorMsg: UILabel!
    
    // Default variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.gray
            }
            if UserDataService.instance.avatarColor != "" {
                userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            }
        }
    }
    @IBAction func createAccntPressed(_ sender: Any) {
        accntErrorMsg.isHidden = true
        spinner.isHidden = false
        spinner.startAnimating()
        guard let name = usernameTxt.text, usernameTxt.text != "" else {
            emptyFieldError()
            return }
        guard let email = emailTxt.text, emailTxt.text != "" else {
            emptyFieldError()
            return }
        guard let pass = passTxt.text, passTxt.text != "" else {
            emptyFieldError()
            return }
        
        if validEmail(email: email) {
            AuthService.instance.registerUser(email: email, password: pass) { (success) in
                if success {
                    AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                        if success {
                            AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                                if success {
                                    self.spinner.stopAnimating()
                                    self.spinner.isHidden = true
                                    self.performSegue(withIdentifier: UNWIND, sender: nil)
                                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                                }
                            })
                        }
                    })
                } else {
                    self.accntErrorMsg.text = "This email is already registered."
                    self.accntErrorMsg.isHidden = false
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                }
            }
        }
    }
    
    func validEmail(email: String) -> Bool {
        if email.lowercased().range(of: "@") == nil || email.lowercased().range(of: ".") == nil {
            accntErrorMsg.text = "Invalid email format."
            accntErrorMsg.isHidden = false
            spinner.stopAnimating()
            spinner.isHidden = true
            return false
        }
        return true
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
        self.avatarColor = "[\(r), \(g), \(b), 1]"
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    func setupView() {
        spinner.isHidden = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func emptyFieldError() {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        accntErrorMsg.text = "The username, email and password fields cannot be empty."
        accntErrorMsg.isHidden = false
    }
    
}
