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
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        let tabBar = GazelleTabBar(config: [
            TabConfig("all_active", "all_inactive", A_VC.self),
            TabConfig("coffee_active", "coffee_inactive", A_VC.self),
            TabConfig("food_active", "food_inactive", A_VC.self),
            TabConfig("study_active", "study_inactive", A_VC.self),
            TabConfig("other_active", "other_inactive", A_VC.self),
        ], startIndex: 0,
           animationStrategy: FadeAnimation(),
           spacingStrategy: EqualSpacing(),
           parent: self,
           tabType: Tab.self,
           height: 50,
           y_origin: 20)
        
        self.view.addSubview(tabBar)
        
//        self.setReferenceImage(name: "ref1")
        
        let l = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        l.backgroundColor = UIColor.blue
        l.textAlignment = .center
        l.textColor = UIColor.white
        l.text = "New Event"
        self.view.addSubview(l)
        l.center = self.view.midPoint
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        l.addGestureRecognizer(tap)
        l.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap() {
        
        // TODO: present the create event vc
        let create = EventCreation_VC(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal)
        self.welcomeChild(create, frame: self.view.bounds)
    }


}

