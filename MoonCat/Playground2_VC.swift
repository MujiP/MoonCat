//
//  Playground2_VC.swift
//  MoonCat
//
//  Created by Yingsi Chu on 2019-12-01.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit
import PromiseKit

class Playground2_VC: UIViewController {
    
//    var g: ProfileGroup!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

//        let v = Tag(string: "Big Nanusaur")
//        v.center = self.view.midPoint
//        v.frame = v.frame.integral
//        self.view.addSubview(v)
//
//        self.setReferenceImage(name: "ref1")
        
        
//        let g = ProfileGroup(profileNames: ["profile_1", "profile_2", "profile_3"], max: 5)
//        self.view.addSubview(g)
//        g.center = self.view.midPoint
//        self.g = g
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)

    }
    
    @objc func handleTap() {
        
        // For creating sample events
        
//        self.g.addProfile(withName: "profile_4")
        
//        let date = Date(year: 2019, month: 12, day: 2, hour: 15, min: 0).timeIntervalSince1970
//        let desc = "Some description about the event goes here, who knows, it can be whatever you want."
//        let new = Event(id: nil,
//                        place: "Starbucks",
//                        area: "Queen Street West",
//                        description: desc,
//                        date: date,
//                        maxOccupancy: 5,
//                        people: ["profile_1", "profile_2", "profile_3", "profile_4"],
//                        tags: ["Coffee"])
        
        let date = Date(year: 2019, month: 12, day: 3, hour: 16, min: 0).timeIntervalSince1970
        let desc = "Some description about the event goes here, who knows, it can be whatever you want."
        let new = Event(id: nil,
                        place: "Robarts Library",
                        area: "Saint George Street",
                        description: desc,
                        date: date,
                        maxOccupancy: 5,
                        people: ["profile_2"],
                        tags: ["Study", "Csc209"])
        
        
        firstly {
            🎟Event(new).run()
        }.done { _ in
            print("Success")
        }.catch { error in
            print(error)
        }
                
                
            
    }

}
