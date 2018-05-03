//
//  Event.swift
//  liveTvSwift
//
//  Created by Ali Raza on 03/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

class Event {
    var name: String
    var live: Bool
    var status: String
    var image_url: String
    var priority: Int
    var channels: [Channel]
    
    init(name: String, live: Bool, status: String, image_url: String, priority: Int, channels: [ Channel])
    {
        self.name = name
        self.live = live
        self.status = status
        self.image_url = image_url
        self.priority = priority
        self.channels = channels
    }
}
