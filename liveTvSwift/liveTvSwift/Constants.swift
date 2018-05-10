//
//  Constants.swift
//  liveTvSwift
//
//  Created by Ali Raza on 04/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import Foundation
import UIKit

let APP_ID                      = 6
let BASE_URL                    = "https://live-sports-tv.herokuapp.com/api/applications/details"
let AUTH_TOKEN                  = "6d0c0cdc967caa3731516a7b6b6ebd33c64c92ac"


let ADD_BLOCKER_CHECKING_TIME   = 4.0
let APP_DISABLED_MESSAGE        = "Server communication error we will get back to you soon"
let ADD_BLOCKER_RUNNING_MSG     = "You are running add blocker please stop it in order to use our app."


//For app id 5
//    let AUTH_TOKEN  = "b50a576a7e6f77eb0c7b431f81f1b69771e7b409"

func APP_DELEGATE() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}
