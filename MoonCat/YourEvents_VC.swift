//
//  YourEvents_VC.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-28.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit
import PromiseKit

class YourEvents_VC: UIViewController, Displaying {
    
    var vc: Events_TVC?
    var loader: CircularLoader!
    var request: Promise<[Event]> {
        return 🎟YourEvents(yourID: User.current.name).run()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHeaderBar()
        self.go()
        
    }
    
    
    /**
     Creates a blur overlay header bar with the create icon
     */
    func setupHeaderBar() {
        let v = BlurView()
        self.view.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            v.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            v.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            v.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        let createIcon = UIImageView(image: UIImage(named: "create"))
        self.view.addSubview(createIcon)
        createIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createIcon.intrinsicHeightConstraint,
            createIcon.intrinsicWidthConstraint,
            createIcon.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -4),
            createIcon.centerYAnchor.constraint(equalTo: v.centerYAnchor, constant: 8)
        ])
        
        let refresh = UIImageView(image: UIImage(named: "refreshIcon"))
        self.view.addSubview(refresh)
        refresh.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refresh.intrinsicWidthConstraint,
            refresh.intrinsicHeightConstraint,
            refresh.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 4),
            refresh.centerYAnchor.constraint(equalTo: v.centerYAnchor, constant: 8)
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(refreshTapped))
        refresh.addGestureRecognizer(tap)
        refresh.isUserInteractionEnabled = true
    }
    
    @objc func refreshTapped() {
        self.refresh()
    }
    


}
