//
//  CenteredSpacing.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-11.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

/** Positions tabs so that they are collectively centered within the tab bar, and spaced by the given padding amount. */
struct CenteredSpacing: SpacingStrategy {
    
    let padding: CGFloat
    
    func layout(tabs: [Tab], tabBar: TabBar) {
        
        let maxW = self.collectiveWidth(tabs: tabs, padding: self.padding)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: maxW, height: tabBar.bounds.height))
        
        self.space(tabs: tabs, padding: self.padding, startWithPadding: false)
        
        for each in tabs {
            container.addSubview(each)
            each.center.y = container.bounds.height / 2
        }
        
        tabBar.addSubview(container)
        container.center = tabBar.midPoint
    }
    
}
