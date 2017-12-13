//
//  Constants.swift
//  Babble
//
//  Created by Pankaj on 01/10/17.
//  Copyright © 2017 Aleph-Labs. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success : Bool) -> ()
typealias CompletionHandlerWithResutlArray = (_ Success : Bool) -> ()

//URL Constants
let BASE_URL = "http://172.20.10.2:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"


//segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreate_Account"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//userdefualt
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
