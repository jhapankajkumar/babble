//
//  UserDataService.swift
//  Babble
//
//  Created by Pankaj on 30/11/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit

class UserDataService {

    static let instace = UserDataService()
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""

    func setUserData(id : String, color: String, avatarName: String, email : String, name: String) {
        self.id = id
        self.avatarColor = color
        self.name = name
        self.avatarName = avatarName
        self.email = email
    }
    
    func setAvatarName(avatarName:String)  {
        self.avatarName = avatarName;
    }
}
