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
    
    
}
