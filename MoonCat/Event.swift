//
//  Event.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-28.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import Foundation

protocol EventDelegate: AnyObject {
    /**
     When the current User just joined the event.
     */
    func didJoin()
    
    /**
     When the current User just left the event.
     */
    func didLeave()
}

class Event {
    
    let place: String // Starbucks
    let area: String // Queen Street West
    let description: String
    let date: Date?
    let maxOccupancy: Int
    var people: [String]
    let tags: [String]
    weak var delegate: EventDelegate?
    
    init(place: String, area: String, description: String, date: Date?, currentOccupancy: Int, maxOccupancy: Int, people: [String], tags: [String]) {
        self.place = place
        self.area = area
        self.description = description
        self.date = date
        self.maxOccupancy = maxOccupancy
        self.people = people
        self.tags = tags
    }
    
    /**
     Has the current User join or leave the event, depending on whether they are part of it or not.
     If they are not part of the event, it has them join. If they are, it has them leave.
     */
    func joinOrLeave() {
        if self.isAttending() {
            self.leave()
        } else {
            self.join()
        }
    }
    
    /**
     Has the current User join the event.
     */
    private func join() {
        // Append the current user
        // Send the Join request
        // Alert delegate
        
        // TODO: Should undo local changes if the join request failed.
        
        self.people.append(User.current.name)
        self.delegate?.didJoin()
    }
    
    /**
    Has the current User leave the event.
     - Precondition: the current user is part of the event.
    */
    private func leave() {
        // Remove the current user
        // Send the Leave request
        // Alert delegate
        
        
        let i = self.people.firstIndex { $0 == User.current.name }!
        self.people.remove(at: i)
        self.delegate?.didLeave()
    }
    
    /**
     Returns true if the current User is part of the event.
     */
    private func isAttending() -> Bool {
        let i = self.people.firstIndex { $0 == User.current.name }
        return i != nil
    }
}
