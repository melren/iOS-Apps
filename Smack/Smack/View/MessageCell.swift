//
//  MessageCell.swift
//  Smack
//
//  Created by Melanie Ren on 12/9/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var msgbodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(message: Message) {
        msgbodyLbl.text = message.messageBody
        usernameLbl.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

}
