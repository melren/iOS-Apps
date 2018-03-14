//
//  AuthService.swift
//  Ivory
//
//  Created by Melanie Ren on 3/13/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    // Interface to user defaults that persist in device (not super secure)
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
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
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    var errorMsg: String {
        get {
            return defaults.value(forKey: ERROR_MSG) as! String
        }
        set {
            defaults.set(newValue, forKey: ERROR_MSG)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionErrorHandler) {
        
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                if let message = response.result.value {
                    if message.lowercased().range(of: "message") != nil {
                        let error = message.components(separatedBy: ":")[1].replacingOccurrences(of: "[\"}]", with: "", options: [.regularExpression])
                        completion(error)
                        return
                    }
                }
                completion("success")
            } else {
                completion("An error occured.")
                //debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
//                if let json = response.result.value as? Dictionary<String, Any> {
//                    if let message = json["message"] as? String {
//                        //couldn't authenticate
//                        print(message)
//                        completion(false)
//                        return
//                    }
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                        print(email)
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                        print(token)
//                    }
//                }
                
                guard let data = response.data else { return }
                if let json = try? JSON(data: data) {
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                }
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = try? JSON(data: data) {
                    let id = json["_id"].stringValue
                    let color = json["avatarColor"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let email = json["email"].stringValue
                    let name = json["name"].stringValue
               
                    UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
}
