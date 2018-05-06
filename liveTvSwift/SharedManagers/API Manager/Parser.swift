//
//  Parser.swift
//  liveTvSwift
//
//  Created by Ali Raza on 04/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import Foundation

func getEventsFromRespns(json: JSON) -> [Event]
{
    var eventsArray: [Event] = []
    
    for result in json["events"].arrayValue
    {
        let name = result["name"].stringValue
        let live = result["live"].boolValue
        let status = result["status"].stringValue
        let image_url = result["image_url"].stringValue
        let priority = result["priority"].intValue
        
        var tempChannels : [Channel] = []
        
        for channel in result["channels"].arrayValue
        {
            let name = channel["name"].stringValue
            let live = channel["live"].boolValue
            let url = channel["url"].stringValue
            let image_url = channel["image_url"].stringValue
            let priority = channel["priority"].intValue
            let channel_type = channel["channel_type"].stringValue
            
            tempChannels.append(Channel(name: name, live: live, url: url, image_url: image_url, priority: priority, channel_type: channel_type))
        }
        
        eventsArray.append(Event(name: name, live: live, status: status, image_url: image_url, priority: priority, channels: tempChannels))
    }
    return eventsArray;
}
func getCategoriesFromRespns(json: JSON) -> [Event]
{
    var eventsArray: [Event] = []
    
    for result in json["categories"].arrayValue
    {
        let name = result["name"].stringValue
        let live = result["live"].boolValue
        let status = result["status"].stringValue
        let image_url = result["image_url"].stringValue
        let priority = result["priority"].intValue
        
        var tempChannels : [Channel] = []
        
        for channel in result["channels"].arrayValue
        {
            let name = channel["name"].stringValue
            let live = channel["live"].boolValue
            let url = channel["url"].stringValue
            let image_url = channel["image_url"].stringValue
            let priority = channel["priority"].intValue
            let channel_type = channel["channel_type"].stringValue
            
            tempChannels.append(Channel(name: name, live: live, url: url, image_url: image_url, priority: priority, channel_type: channel_type))
        }
        
        eventsArray.append(Event(name: name, live: live, status: status, image_url: image_url, priority: priority, channels: tempChannels))
    }
    return eventsArray;
}
