//
//  EventInfo.swift
//  MoonCat
//
//  This structure is for storing information of an event. An instance of this structure
//  is created when the user completes the event creation form and taps the "create" button.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import Foundation
struct EventInfo {
    // structure def goes here
    /*
     event name - string
     location - string
     category - string
     start time - date time
     end time - date time
     description - string
     max num people - string into num
     show contact - boolean
     */
    
    // type annotations of EventInfo properties
    // pass values of these properties when creating a new instance of EventInfo 
    var eventName: String
    var location: String
    var category: String
    var startTime: String
    var endTime: String
    var description: String
    var maxNumPeople: String
    var showContact: Bool
    
    
    func printEvent() {
        print(eventName)
    }
 
}
