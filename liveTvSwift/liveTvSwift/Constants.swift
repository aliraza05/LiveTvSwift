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
let BASE_URL                     = "https://live-sports-tv.herokuapp.com/api/applications/details"
let AUTH_TOKEN                   = "6d0c0cdc967caa3731516a7b6b6ebd33c64c92ac"

//More View Controller Constants

let TERMS_URL                    = "http://onlinemobilestream.com"
let MORE_APPS_URL                = "http://onlinemobilestream.com"
let RATE_US_URL                  = "http://onlinemobilestream.com"

let FEEDBACK_EMAIL               = "cricketcrazeios3@gmail.com"

let ADD_BLOCKER_CHECKING_TIME    = 30.0
let APP_DISABLED_MESSAGE         = "Server communication error we will get back to you soon"
let ADD_BLOCKER_RUNNING_MSG      = "You are running add blocker please stop it in order to use our app."

let ADMOB_APP_ID                 = "ca-app-pub-2498422838695550/7845405823"
let ADMOB_BANNER_ID              = "ca-app-pub-3940256099942544/2934735716"
let ADMOB_INTERSTITIAL_ID        = "ca-app-pub-3940256099942544/4411468910"

let CHARTBOOST_ID                = "SOMETHING"
let CHARTBOOST_SIG               = "SOMETHING"


let STARTAPP_ID                  = "207757391"
//For app id 5
//    let AUTH_TOKEN  = "b50a576a7e6f77eb0c7b431f81f1b69771e7b409"

func APP_DELEGATE() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}
