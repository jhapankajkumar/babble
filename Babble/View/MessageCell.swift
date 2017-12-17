//
//  MessageCell.swift
//  Babble
//
//  Created by Pankaj on 17/12/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configuareCell(message : Message) {
        self.message.text = message.message
        self.userName.text = message.userName
        self.profileImage.image = UIImage(named: message.userAvatar)
        self.profileImage.backgroundColor = UserDataService.instace.getColor(colors: message.avatarColor)
    }

}
