//
//  Constants.swift
//  Smack
//
//  Created by Nathaniel Burciaga on 2/2/18.
//  Copyright © 2018 Nathaniel Burciaga. All rights reserved.
//

import Foundation

// Completion Handler for AuthService
typealias CompletionHandler = (_ Success: Bool) -> ()


// URL Constants
let BASE_URL = "https://chattychatnb.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"


//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"


//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


//Headers for AuthService
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"]




