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
    
    func setupTabBar() {
        let vc = TabBar_VC(config: [
            TabConfig("list_active", "list_inactive", AllEvents_VC.self),
            TabConfig("star_active", "star_inactive", YourEvents_VC.self)
            ], startIndex: 0,
               transitionStyle: .slide,
               layoutStyle: .center(padding: 50),
               tabType: Tab.self)
        
        
        self.welcomeChild(vc) { (v) in
            self.view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                v.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                v.heightAnchor.constraint(equalToConstant: 50),
                v.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
            ])
            
            let b = BlurView()
            self.view.insertSubview(b, at: 0)
            b.pinTo(v)
            
        }
    }
    



}

