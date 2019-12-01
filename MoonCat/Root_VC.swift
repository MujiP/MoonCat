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
        self.setupTabBar()

        
    }
    
    @objc func handleTap() {
        
        // TODO: present the create event vc
        let create = EventCreation_VC(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal)
        self.welcomeChild(create, frame: self.view.bounds)
    }
    



}

