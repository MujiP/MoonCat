//
//  ProfileGroup.swift
//  MoonCat
//
//  Created by Yingsi Chu on 2019-12-01.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

/**
 Displays profiles in an overlapping fashion.
 */
class ProfileGroup: UIView {
    
    private var index: Int
    private var views: [UIImageView]
    
    /**
     - Precondition: Images exist for the passed in profile names. And the count doesn't exceed max.
     */
    init(profileNames: [String], max: Int) {
        
        // Create the profile images
        // Create any blanks
        // Space them out
        // Keep track of the index of the first blank, to slot new profiles in.
        
        // Note: the profile images are slightly larger than the blank image due to the shadow,
        // so space all elements out according to this width and not the width of the blank,
        // since blanks can be replaced by profile images later.
        // All profile image assets are the same size.
        
        // And create the blanks at the size of the profile image, with centered setting.
        
        var index = 0
        
        var views = [UIImageView]()
        for name in profileNames {
            let imv = UIImageView(image: UIImage(named: name))
            imv.contentMode = .center
            views.append(imv)
            index += 1
        }
        
        self.index = index
        
        let blanks = max - profileNames.count
        let profileReference = UIImageView(image: UIImage(named: "profile_1"))
        
        for _ in 1...blanks {
            let imv = UIImageView(frame: profileReference.bounds)
            imv.contentMode = .center
            imv.image = UIImage(named: "profile_blank")
            views.append(imv)
        }
        
        self.views = views
        
        var padding: CGFloat = 30 // tweak as needed
        var x: CGFloat = 0
        
        for each in views {
            each.frame.origin.x = x
            x += padding
        }
        
        x -= padding
        x += profileReference.bounds.width
        
        super.init(frame: CGRect(x: 0, y: 0, width: x, height: profileReference.bounds.height))
        
        
        views.map { self.insertSubview($0, at: 0); $0.frame = $0.frame.integral }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Slots a new profile image into the first blank spot in the group.
     
     - Precondition: an image exists for the passed in profile name.
     */
    func addProfile(withName name: String) {
        
        if self.index == self.views.count {
            // All slots are filled up
            return
        }
        
        self.views[self.index].image = UIImage(named: name)
        self.index += 1
    }
    
    func removeProfile(atIndex n: Int) {
        
        // Find index of the profile
        // Loop, starting at that index.
        // Set that image to its neighbours.
        // On the last iteration, set it to blank.
        
        let count = self.views.count
        for i in n..<count {
            if i == count - 1 {
                self.views[i].image = UIImage(named: "profile_blank")
                break
            }
            
            let v1 = self.views[i]
            let v2 = self.views[i + 1]
            v1.image = v2.image
            
        }
        
        self.index -= 1
        
    }
    
}

