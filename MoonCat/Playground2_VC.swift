//
//  Playground2_VC.swift
//  MoonCat
//
//  Created by Yingsi Chu on 2019-12-01.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

class Playground2_VC: UIViewController {
    
    var g: ProfileGroup!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

//        let v = Tag(string: "Big Nanusaur")
//        v.center = self.view.midPoint
//        v.frame = v.frame.integral
//        self.view.addSubview(v)
//
//        self.setReferenceImage(name: "ref1")
        
        
        let g = ProfileGroup(profileNames: ["profile_1", "profile_2", "profile_3"], max: 5)
        self.view.addSubview(g)
        g.center = self.view.midPoint
        self.g = g
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)

    }
    
    @objc func handleTap() {
        self.g.addProfile(withName: "profile_4")
    }

}
