//
//  AuthService.swift
//  Smack
//
//  Created by Melanie Ren on 12/4/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//  Handle log in and resgister users

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    //create singleton, one global instance at a time
    static let instance = AuthService()
    
    //info saved even after app is closed, persistent across app launches
    let defaults = UserDefaults.standard    //use for simple things, not very secure so don't store passwords
    
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
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]

        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                print(response)
                if let message = response.result.value as? String {
                    if message.lowercased().range(of: "message") != nil {
                        completion(false)
                        return
                    }
                }
                completion(true)    //refers to custom completion handler in the func input
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
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
                if let json = response.result.value as? Dictionary<String, Any> {
                    if let message = json["message"] as? String {       // this means you couldn't authenticate
                        print(message)
                        completion(false)
                        return
                    }
                    if let email = json["user"] as? String {
                        self.userEmail = email
                        print(email)
                    }
                    if let token = json["token"] as? String {
                        self.authToken = token
                        print(token)
                    }
                }
                
                //rewritten with SwiftyJSON
//                guard let data = response.data else { return }
//                let json = JSON(data: data)
//                self.userEmail = json["user"].stringValue
//                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            } else {
                
                debugPrint(response.result.error as Any)
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
                if let json = response.result.value as? Dictionary<String, Any> {
                    self.setUserInfo(json: json)
                    completion(true)
                }
                    
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String, Any> {
                    self.setUserInfo(json: json)
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func setUserInfo(json: Dictionary<String, Any>) {
        guard let id = json["_id"] as? String else { return }
        guard let avatarColor = json["avatarColor"] as? String else { return }
        guard let avatarName = json["avatarName"] as? String else { return }
        guard let email = json["email"] as? String else { return }
        guard let name = json["name"] as? String else { return }
        
        UserDataService.instance.setUserData(id: id, color: avatarColor, avatarName: avatarName, email: email, name: name)
    }

}


