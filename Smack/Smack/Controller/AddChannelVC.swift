//
//  AddChannelVC.swift
//  Smack
//
//  Created by Melanie Ren on 12/6/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    // Outlets
    @IBOutlet weak var nameTxt: ColoredPlaceHolderText!
    @IBOutlet weak var chanDesc: ColoredPlaceHolderText!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChanPressed(_ sender: Any) {
        guard let channelName = nameTxt.text, nameTxt.text != "" else { return }
        guard let channelDesc = chanDesc.text else { return }
        
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }

    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
