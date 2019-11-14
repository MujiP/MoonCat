//
//  EqualSpacing.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-11.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

/** Positions tabs so that the space between consecutive tabs, as well as the space between end tabs and the tab bar, are all equal. */
struct EqualSpacing: SpacingStrategy {
    
    func layout(tabs: [Tab], tabBar: TabBar) {
        
        // Determine the collective width of all tabs
        // Determine the left over space
        // Divide that space by number of tabs + 1
        
        let totalWidth = self.collectiveWidth(tabs: tabs, padding: 0)
        let leftover = tabBar.bounds.width - totalWidth
        let spacing = floor(leftover / CGFloat(tabs.count + 1))
        self.space(tabs: tabs, padding: spacing, startWithPadding: true)
        
        for each in tabs {
            tabBar.addSubview(each)
            each.center.y = tabBar.bounds.height / 2
            each.frame = each.frame.integral
        }
    }
    
}
