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
        
    }

}
