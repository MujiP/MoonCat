//
//  Root_VC.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-05.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

class Root_VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        let vc = GazelleTabBar_VC(config: [
            TabConfig("all_active", "all_inactive", A_VC.self),
            TabConfig("coffee_active", "coffee_inactive", A_VC.self),
            TabConfig("food_active", "food_inactive", A_VC.self),
            TabConfig("study_active", "study_inactive", A_VC.self),
            TabConfig("other_active", "other_inactive", A_VC.self),
        ], startIndex: 0,
           transitionStyle: .fade,
           layoutStyle: .equal,
           tabType: Tab.self)
        
        self.welcomeChild(vc) { (v) in
            self.view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
                v.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
                v.heightAnchor.constraint(equalToConstant: 50),
                v.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }


//
//        tabBar.backgroundColor = UIColor.red.withAlphaComponent(0.2)
//
//        self.view.addSubview(tabBar)
//        tabBar.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            tabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            tabBar.heightAnchor.constraint(equalToConstant: 50),
//            tabBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100)
//        ])
        
        
        
//        self.setReferenceImage(name: "ref1")
        
//        let l = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
//        l.backgroundColor = UIColor.blue
//        l.textAlignment = .center
//        l.textColor = UIColor.white
//        l.text = "New Event"
//        self.view.addSubview(l)
//        l.center = self.view.midPoint
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        l.addGestureRecognizer(tap)
//        l.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap() {
        
//        // TODO: present the create event vc
//        let vc = CreateEvent_VC()
//        self.welcomeChild(vc, frame: self.view.bounds)
        
        
    }


}

