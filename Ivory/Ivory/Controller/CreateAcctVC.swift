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
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }

    // Actions
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAcctPressed(_ sender: Any) {
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
                            }
                        })
                    }
                })
            } else {
                self.errorTxt.text = completion
                self.errorTxt.isHidden = false
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    func displayError() {
        errorTxt.text = "Fields cannot be left blank."
        errorTxt.isHidden = false
    }

}
