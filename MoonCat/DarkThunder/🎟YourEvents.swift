//
//  🎟YourEvents.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-29.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import Foundation
import Bifrost

struct 🎟YourEvents: ParsedRequestable {
    
    var HTTPMethod = "GET"
    var host = "darkthunder-1.herokuapp.com"
    var path = "/events"
    
    var bufferTag = "DarkThunder"
    var payload: Any?
    var queryParameters: [String : [String]]?
    var headers: [String : String]?
    var signer: Signing?
    
    typealias ExpectedObjType = [[String: Any]]
    typealias ParsedType = [Event]
    
    init(yourID: String) {
        self.path += "/" + yourID
    }
    
    func parsingFunction(obj: [[String : Any]]) -> ([Event]?) {
        
        var events = [Event]()
        
        for each in obj {
            
            // Note: Can't cast a string directly to a Double, Int or TimeInterval
            
            if let place = each["place"] as? String,
                let area = each["area"] as? String,
                let description = each["description"] as? String,
                
                let date_string = each["date"] as? String,
                let date = Double(date_string) as? TimeInterval,
                
                let maxOccupancy_string = each["maxOccupancy"] as? String,
                let maxOccupancy = Int(maxOccupancy_string),
                
                let people = each["people"] as? [String],
                let id = each["id"] as? String,
                let tags = each["tags"] as? [String] {
                
                // TODO: remove currentOccupancy, handle date properly, add id.
                events.append(Event(id: id, place: place, area: area, description: description, date: date, maxOccupancy: maxOccupancy, people: people, tags: tags))
            }
        }
        
        return events
    }
    
}

