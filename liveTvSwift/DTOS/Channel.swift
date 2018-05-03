//
//  Channel.swift
//  liveTvSwift
//
//  Created by Ali Raza on 03/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

class Channel {
    var name: String
    var live: Bool
    var url: String
    var image_url: String
    var priority: Int
    var channel_type: String

    
    init(name: String, live: Bool, url: String, image_url: String, priority: Int,channel_type: String) {
        self.name = name
        self.live = live
        self.url = url
        self.image_url = image_url
        self.priority = priority
        self.channel_type = channel_type
    }
}

