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
    func didJoin(event: Event)
    
    /**
     When the current User just left the event.
     */
    func didLeave(event: Event)
}

class Event {
    
    var id: String? // Events from backend will have an id. Events created on client side will not.
    let place: String // Starbucks
    let area: String // Queen Street West
    let description: String
    let date: TimeInterval
    let maxOccupancy: Int
    var people: [String]
    let tags: [String]
    weak var delegate: EventDelegate?
    
    /**
     For the date, pass a time interval since 1970
     */
    init(id: String?, place: String, area: String, description: String, date: TimeInterval, maxOccupancy: Int, people: [String], tags: [String]) {
        self.id = id
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
        self.delegate?.didJoin(event: self)
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
        self.delegate?.didLeave(event: self)
    }
    
    /**
     Returns true if the current User is part of the event.
     */
    private func isAttending() -> Bool {
        let i = self.people.firstIndex { $0 == User.current.name }
        return i != nil
    }
}
