//
//  AuthService.swift
//  Smack
//
//  Created by Melanie Ren on 12/4/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//  Handle log in and resgister users

import Foundation
import Alamofire

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
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)    //refers to custom completion handler in the func input
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}


