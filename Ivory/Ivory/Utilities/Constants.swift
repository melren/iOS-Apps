//
//  Constants.swift
//  Ivory
//
//  Created by Melanie Ren on 3/13/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()
typealias CompletionErrorHandler = (_ Message: String) -> ()

// Colors
let IVORY_PLACEHOLDER = #colorLiteral(red: 0.409147501, green: 0.5773295164, blue: 0.751957953, alpha: 0.5)

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCT = "toCreateAcct"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
let ERROR_MSG = "errorMsg"

// URLS
let BASE_URL = "https://mivory.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]



