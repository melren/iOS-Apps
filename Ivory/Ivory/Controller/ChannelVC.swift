//
//  ChannelVC.swift
//  Ivory
//
//  Created by Melanie Ren on 3/12/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize rear view reveal width
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

}
