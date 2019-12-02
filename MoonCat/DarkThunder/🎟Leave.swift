//
//  🎟Leave.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-30.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import Foundation
import Bifrost

struct 🎟Leave: Requestable {
    
    var HTTPMethod = "POST"
    var host = "darkthunder-1.herokuapp.com"
    var path = "/leave"
    
    var bufferTag = "DarkThunder"
    var payload: Any?
    var queryParameters: [String : [String]]?
    var headers: [String : String]?
    var signer: Signing?
    
    typealias ExpectedObjType = X
    
    init(eventID: String, yourID: String) {
        self.path += "/" + eventID + "/" + yourID
    }
}
