//
//  Constants.swift
//  liveTvSwift
//
//  Created by Ali Raza on 04/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import Foundation
import UIKit

let APP_ID                       = 6
let BASE_URL                     = "https://www.nospacedidlove.com/api/applications/details"
let AUTH_TOKEN                   = "6d0c0cdc967caa3731516a7b6b6ebd33c64c92ac"


//let APP_ID                       = 13
//let AUTH_TOKEN                   = "70ee5a595d1779b7b98265a7129e5c75d6f55911"

//More View Controller Constants

let TERMS_URL                    = "http://onlinemobilestream.com/privacy-policy/"
let MORE_APPS_URL                = "http://onlinemobilestream.com"
let RATE_US_URL                  = "https://itunes.apple.com/us/app/live-sports-tv-hd/id1391202609?ls=1&mt=8"

let FEEDBACK_EMAIL               = "cricketcrazeios3@gmail.com"

let ADD_BLOCKER_CHECKING_TIME    = 30.0
let APP_DISABLED_MESSAGE         = "Server communication error we will get back to you soon"
let ADD_BLOCKER_RUNNING_MSG      = "You are running add blocker please stop it in order to use our app."

let ADMOB_APP_ID                 = "ca-app-pub-2498422838695550~2955082663"
//let ADMOB_BANNER_ID              = "ca-app-pub-2498422838695550/7904157013"

//Test
let ADMOB_BANNER_ID              = "ca-app-pub-3940256099942544/2934735716"

let ADMOB_INTERSTITIAL_ID        = "ca-app-pub-2498422838695550/2871198479"
let ADMOB_VIDEOADD_ID            = "ca-app-pub-2498422838695550/5520677421"

let CHARTBOOST_ID                = "5b0d86b753eee8116c4d4a40"
let CHARTBOOST_SIG               = "4d025e65130e48815d889f999741e006634f8eba"


let STARTAPP_ID                  = "207757391"
//For app id 5
//    let AUTH_TOKEN  = "b50a576a7e6f77eb0c7b431f81f1b69771e7b409"

func APP_DELEGATE() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}
