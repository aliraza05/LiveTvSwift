//
//  Parser.swift
//  liveTvSwift
//
//  Created by Ali Raza on 04/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import Foundation
import UIKit

func getEventsFromRespns(json: JSON) -> [Event]
{
    var eventsArray: [Event] = []
    
    for result in json["events"].arrayValue
    {
        let name = result["name"].stringValue
        let live = result["live"].boolValue
        let status = result["status"].stringValue
        let image_url = result["image_url"].stringValue
        let thumbnail_image = result["thumbnail_image"].stringValue
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
            
            if live
            {
                tempChannels.append(Channel(name: name, live: live, url: url, image_url: image_url, priority: priority, channel_type: channel_type))
            }
        }
        
        if live && tempChannels.count > 0
        {
            tempChannels.sort(by: { $0.priority < $1.priority })

            eventsArray.append(Event(name: name, live: live, status: status, image_url: image_url,thubnail: thumbnail_image, priority: priority, channels: tempChannels))
        }
    }
    
    eventsArray.sort(by: { $0.priority < $1.priority })

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
        let thumbnail_image = result["thumbnail_image"].stringValue
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
            
            if live
            {
                tempChannels.append(Channel(name: name, live: live, url: url, image_url: image_url, priority: priority, channel_type: channel_type))
            }
        }
        if live && tempChannels.count > 0
        {
            tempChannels.sort(by: { $0.priority < $1.priority })

            eventsArray.append(Event(name: name, live: live, status: status, image_url: image_url,thubnail: thumbnail_image, priority: priority, channels: tempChannels))
        }
    }
    
    eventsArray.sort(by: { $0.priority < $1.priority })
    
    return eventsArray;
}

