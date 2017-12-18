//
//  MessageService.swift
//  Babble
//
//  Created by Pankaj on 14/12/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    var channels = [Channel]()
    var messages = [Message]()
    
    var selectedChannel = Channel()
    

    func getChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data =  response.data else {return}
                if let channelData = JSON(data: data).array {
                    if channelData.count > 0 {
                        self.channels.removeAll()
                    }
                    for item in channelData {
                        let name  = item["name"].string
                        let description  = item["description"].string
                        let id  = item["_id"].string
                        let v  = item["__v"].string
                        
                        let channel = Channel(name: name, description: description, _id: id, __v: v)
                        self.channels.append(channel)
                        print(name!)
                    }
                    
                    NotificationCenter.default.post(name: NOTIF_USER_CHANNEL_DID_LOADED, object: nil)
                    completion(true)
                }
            }
            else {
                completion(false)
            }
        }
    }
    
    func addChannel(name: String, description: String,   completion: @escaping CompletionHandler) {
     
        let channelName = name.lowercased()
        
        let body : [String: Any] = [
            "name" : channelName,
            "description" : description
        ]
        
        Alamofire.request(URL_ADD_CHANNEL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else{return}
                print(data)
                completion(true)
            }
            else{
                completion(false)
            }
        }
        
    }
    
    func getMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessage()
                guard let data = response.data else {return}
                if let json = JSON(data: data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let id = item["_id"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, avatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                        
                    }
                    completion(true)
                }
            }
            else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
        
    }
    
    func clearMessage()   {
        self.messages.removeAll()
    }
    
    func clearChannel() {
        self.channels.removeAll()
    }
    
}
