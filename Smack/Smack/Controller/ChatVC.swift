//
//  ChatVC.swift
//  Smack
//
//  Created by Melanie Ren on 11/29/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tap on button to reveal
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //swipe to reveal
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //tap anywhere on chatVC to go back to it
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if AuthService.instance.isLoggedIn == true {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
            
            MessageService.instance.findAllChannel(completion: { (success) in
                
                
            })
        }
        
        
    }


}
