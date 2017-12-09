//
//  MessageService.swift
//  Smack
//
//  Created by Melanie Ren on 12/6/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import Foundation
import Alamofire

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel : Channel?
    var messages = [Message]()      // store messages for one channel at a time
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {

                guard let data = response.data else { return }
                
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
//                if let jsonArray = response.result.value as? [Dictionary<String, Any>] {
//                    for item in jsonArray {
//                        guard let name = item["name"] as? String else { return }
//                        guard let channelDescription = item["description"] as? String else { return }
//                        guard let id = item["_id"] as? String else { return }
//
//                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
//                        self.channels.append(channel)
//                    }
//
//                    completion(true)
//                }
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func findAllMessages(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                do {
                    self.messages = try JSONDecoder().decode([Message].self, from: data)
                    print(self.messages)
                } catch let error {
                    debugPrint(error as Any)
                }
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
}
