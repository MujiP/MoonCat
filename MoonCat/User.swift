//
//  User.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-30.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import Foundation

class User {
    static let current = User()
    
    private init() {} // Singleton pattern
    
    let name = "profile_4"
}
