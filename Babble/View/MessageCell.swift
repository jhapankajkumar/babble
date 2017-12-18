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
        
        guard var date = message.timeStamp else {return}
        let end = date.index(date.endIndex, offsetBy: -5)
        date = date.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: date.appending("Z"))
        
        let newFormatter =  DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStamp.text  = finalDate
        }
    
    }

}
