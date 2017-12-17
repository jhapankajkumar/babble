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
    
    func getColor(colors: String
        ) -> UIColor {
        let scanner = Scanner(string: colors)
        let skippedCharacters = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped  = skippedCharacters
        
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let redUnwrapped = r else {return defaultColor}
        guard let greenUnwrapped = g else {return defaultColor}
        guard let blueUnwrapped = b else {return defaultColor}
        guard let alphaUnwrapped = a else {return defaultColor}
        
        let redFloat = CGFloat(redUnwrapped.doubleValue)
        let greenFloat = CGFloat(greenUnwrapped.doubleValue)
        let blueFloat = CGFloat(blueUnwrapped.doubleValue)
        let alphaFloat = CGFloat(alphaUnwrapped.doubleValue)
        
        let color = UIColor(red: redFloat, green: greenFloat, blue: blueFloat, alpha: alphaFloat)
        
        return color
    }
    
    func logoutUser()  {
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        id = ""
        
        AuthService.instance.isLoggedIn = false;
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannel()
    }
    
}
