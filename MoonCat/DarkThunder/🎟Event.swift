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
    
    init() {
        
        // TODO: Replace this to take in an Event struct and put its info in the payload / path
        
        self.path += "/" + "coffee"
        self.payload = [
            "name": "foo",
            "location": "starbucks",
            "start_time": "3",
            "end_time": "4"
        ]
    }
    
}
