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
    
    static let instace = MessageService()
    var channels = [Channel]()
    

    func getChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data =  response.data else {return}
                
                if let channelData = JSON(data: data).array {
                    
                    for item in channelData {
                        let name  = item["name"].string
                        let description  = item["description"].string
                        let id  = item["_id"].string
                        let v  = item["__v"].string
                        
                        let channel = Channel(name: name, description: description, _id: id, __v: v)
                        self.channels.append(channel)
                        print(name!)
                    }
                    
                    completion(true)
                }
            }
            else {
                completion(false)
            }
        }
    }
}
