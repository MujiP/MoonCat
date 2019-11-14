//
//  GazelleTabBar.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-12.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit


/**
 A Google style tab bar with an active line under the current tab.
 Switching between tabs animates the active line to be under the new tab, with a new width that matches that tab.
 */
class GazelleTabBar: TabBar {
    
    let activeLine: UIView
    
    override init(config: [TabConfig], startIndex: Int, animationStrategy: AnimationStrategy, spacingStrategy: SpacingStrategy, parent: UIViewController, tabType: Tab.Type, height: CGFloat, y_origin: CGFloat) {
        
        let activeLine = UIView()
        activeLine.backgroundColor = #colorLiteral(red: 0.2200894952, green: 0.4641377926, blue: 0.8669697642, alpha: 1)
        activeLine.bounds.size.height = 2
        self.activeLine = activeLine
        
        super.init(config: config, startIndex: startIndex, animationStrategy: animationStrategy, spacingStrategy: spacingStrategy, parent: parent, tabType: tabType, height: height, y_origin: y_origin)
        
        // Configure active line for the starting tab
        
        let startTab = self.tabs[startIndex]
        activeLine.bounds.size.width = startTab.bounds.width - 27 // to negate the padding applied to assets
        activeLine.center = startTab.center
        self.addSubview(activeLine)
        activeLine.frame.origin.y = startTab.frame.origin.y + startTab.bounds.height - 16 // to negate some of the padding applied to assets
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tabWasPressed(_ tab: Tab) {
        super.tabWasPressed(tab)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: [], animations: {
            self.activeLine.bounds.size.width = tab.bounds.width - 27
            self.activeLine.center.x = tab.center.x
        }, completion: nil)
    }
    
}
