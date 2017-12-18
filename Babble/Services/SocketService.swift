//
//  SocketService.swift
//  Babble
//
//  Created by Pankaj on 17/12/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    func startConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDesc: String, completion: @escaping CompletionHandler) {
      socket.emit("newChannel", channelName,channelDesc)
       completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            let channel = Channel(name: channelName, description: channelDesc, _id: channelId, __v: nil)
            MessageService.instance.channels.append(channel)
            completion(true)
        }
    }
    
    func sendMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instace
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getMessage(completion: @escaping (_ message: Message)-> Void) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else {return}
            guard let userId = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let avatar = dataArray[4] as? String else {return}
            guard let avatarColor = dataArray[5] as? String else {return}
            guard let messageid = dataArray[5] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: avatar, avatarColor: avatarColor, id: messageid, timeStamp: timeStamp)
            
            completion(message)
         }
    }
    
    func getTypeingUser(_ completionHandeler: @escaping (_ typingUsers: [String: String])-> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else {return}
            //guard let channelId = dataArray[1] as? String else {return}
            completionHandeler(typingUsers)
        }
    }
    
    func stopTypingUser(){
        let userName = UserDataService.instace.name
        socket.emit("stopType", userName)
    }
    
    func startTypingUser() {
        guard let channelId = MessageService.instance.selectedChannel._id else {return}
        let userName = UserDataService.instace.name
        socket.emit("startType", userName,channelId)
    }
}
