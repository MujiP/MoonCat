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
    
    func layout(tabs: [Tab], tabBar: TabBar_VC) {
        
        let maxW = self.collectiveWidth(tabs: tabs, padding: self.padding)
        
        // Alter the default space method to take in a startPadding that doesn't necessarily have to be equal to the inter tab padding.
        // Then the only thing this struct needs to do is calculate the correct start padding.
        
        
        let startX = (tabBar.view.bounds.width - maxW) / 2
        self.space(tabs: tabs, padding: self.padding, startPadding: startX)
    }
    
}
