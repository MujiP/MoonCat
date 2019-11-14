//
//  TabConfig.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-10.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

/** A struct representing a configuration for a Tab in a TabBar. */
struct TabConfig {
    
    let activeImageString: String
    let inactiveImageString: String
    let type: UIViewController.Type
    
    init(_ activeImageString: String, _ inactiveImageString: String, _ type: UIViewController.Type) {
        self.activeImageString = activeImageString
        self.inactiveImageString = inactiveImageString
        self.type = type
    }
}
