//
//  Channel.swift
//  Babble
//
//  Created by Pankaj on 14/12/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import Foundation
struct Channel:Decodable {
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var _id: String!
    public private(set) var __v: String!
}
