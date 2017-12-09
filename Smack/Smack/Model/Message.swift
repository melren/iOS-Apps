//
//  Message.swift
//  Smack
//
//  Created by Melanie Ren on 12/9/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import Foundation

//struct Message_old {
//    public private(set) var message: String!
//    public private(set) var userName: String!
//    public private(set) var channelId: String!
//    public private(set) var userAvatar: String!
//    public private(set) var userAvatarColor: String!
//    public private(set) var id: String!
//    public private(set) var timeStamp: String!
//}

struct Message : Decodable {
    public private(set) var _id: String!
    public private(set) var messageBody: String!
    public private(set) var userId: String!
    public private(set) var channelId: String!
    public private(set) var userName: String!
    public private(set) var userAvatar: String!
    public private(set) var userAvatarColor: String!
    public private(set) var __v: Int?
    public private(set) var timeStamp: String!
}
