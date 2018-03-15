//
//  MessageService.swift
//  Ivory
//
//  Created by Melanie Ren on 3/14/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    // Place to store channels
    var channels = [Channel]()
    
    // Function to retrieve channels
    func findAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = try? JSON(data: data).array {
                    for item in json! {
                        let name = item["name"].stringValue
                        let desc = item["description"].stringValue
                        let id = item["_id"].stringValue
                        
                        let channel = Channel(channelTitle: name, channelDesc: desc, id: id)
                        self.channels.append(channel)
                    }
                    
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
