//
//  Constants.swift
//  Babble
//
//  Created by Pankaj on 01/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success : Bool) -> ()

//URL Constants
let BASE_URL = "http://192.168.1.2:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"


//segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreate_Account"
let UNWIND = "unwindToChannel"

//userdefualt
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
