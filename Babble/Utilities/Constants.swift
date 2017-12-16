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

var ipAddress = AuthService.instance.getWiFiAddress()

let BASE_URL = "http://\(ipAddress!):3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel"
let URL_ADD_CHANNEL = "\(BASE_URL)/channel/add"


//Notification Constants

let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("userDataChangedNotification")

//segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreate_Account"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"
let TO_PROFILE_VIEW = "toProfileView"


//userdefualt
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


//Bearer Header

let BEARER_HEADER =  [
    "Content-Type" : "application/json; charset=utf-8",
    "Authorization": "Bearer \(AuthService.instance.authToken)"
]


