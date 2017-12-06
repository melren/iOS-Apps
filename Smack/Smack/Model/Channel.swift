//
//  Channel.swift
//  Smack
//
//  Created by Melanie Ren on 12/6/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import Foundation

//struct Channel {
//    public private(set) var channelTitle: String!
//    public private(set) var channelDescription: String!
//    public private(set) var id: String!
//}

struct Channel : Decodable {
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v: Int?
}
