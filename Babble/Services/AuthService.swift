//
//  AuthService.swift
//  Babble
//
//  Created by Pankaj on 07/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class  AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(withEmail email: String, andPassword password: String, completion: @escaping CompletionHandler) {
        let lowercaseEmail = email.lowercased()
        let header = [
            "Content-Type" : "application/json; charset=utf-8"
        ]
        let body : [String: Any] = [
            "email" : lowercaseEmail,
            "password" : password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            }
            else
            {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func loginUser(withUserName userName: String, andPassword password: String, completion: @escaping CompletionHandler) {
        let lowercaseUser = userName.lowercased()
        let header = [
            "Content-Type" : "application/json; charset=utf-8"
        ]
        let body : [String: Any] = [
            "email" : lowercaseUser,
            "password" : password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                let json  = JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                self.isLoggedIn = true
                completion(true)
            }
            else
            {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        })
    }

    
    func createUser(name: String, email:String, avatarName:String, avatarColor: String, completion: @escaping CompletionHandler) {
        let lowercaseEmail = email.lowercased()
        let header = [
            "Content-Type" : "application/json; charset=utf-8",
            "Authorization": "Bearer \(AuthService.instance.authToken)"
        ]
        let body : [String: Any] = [
            "email" : lowercaseEmail,
            "name" : name,
            "avatarName": avatarName,
            "avatarColor" : avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error  == nil {
                guard let data = response.data else { return}
                
                let json = JSON(data: data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
                
                UserDataService.instace.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)

                completion(true)
                
            }
            else
            {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
    
    
}










