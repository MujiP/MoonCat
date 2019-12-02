//
//  🎟Event.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-13.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import Foundation
import Bifrost

struct 🎟Event: Requestable {
    
    var HTTPMethod = "POST"
    var host = "darkthunder-1.herokuapp.com"
    var path = "/events"
    
    var bufferTag = "DarkThunder"
    var payload: Any?
    var queryParameters: [String : [String]]?
    var headers: [String : String]?
    var signer: Signing?
    
    typealias ExpectedObjType = X
    
    init(_ event: Event) {
        
        self.payload = [
            "place": event.place,
            "area": event.area,
            "description": event.description,
            "date": event.date,
            "maxOccupancy": event.maxOccupancy,
            "people": event.people,
            "tags": event.tags
        ]
    }
    
}
