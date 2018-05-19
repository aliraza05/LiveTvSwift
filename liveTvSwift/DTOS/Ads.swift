//
//  Ads.swift
//  liveTvSwift
//
//  Created by Ali  Raza on 18/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import Foundation

class Ads
{
    
    var provider: String
//    var enable: Bool
    var locations: [String] = []
    
    init(provider: String, locations: [ String])
    {
        self.provider = provider
        self.locations = locations
    }
}
