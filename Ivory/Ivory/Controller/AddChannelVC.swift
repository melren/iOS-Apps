//
//  AddChannelVC.swift
//  Ivory
//
//  Created by Melanie Ren on 3/14/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    // Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameTxt: ColoredPlaceHolderText!
    @IBOutlet weak var chanDesc: ColoredPlaceHolderText!
    @IBOutlet weak var errorTxt: UILabel!
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // add ability to dismiss keyboard on tap off
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }

    // Actions
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createChanPressed(_ sender: Any) {
        errorTxt.isHidden = true
        guard let channelName = nameTxt.text, nameTxt.text != "" else {
            errorTxt.isHidden = false
            return
        }
        if channelName.count > 12 {
            self.errorTxt.text = "Channel name cannot exceed 12 characters."
            errorTxt.isHidden = false
            return
        }
        guard let channelDesc = chanDesc.text else { return }
        
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
