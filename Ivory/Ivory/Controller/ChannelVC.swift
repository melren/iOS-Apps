//
//  ChannelVC.swift
//  Ivory
//
//  Created by Melanie Ren on 3/12/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    // Outlets
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize rear view reveal width
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    // Actions
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
}
