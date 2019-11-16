//
//  SpacingStrategy.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-10.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

/**
 Performs only horizontal layout of tabs in a TabBar.
 Has some default methods available to assist the conforming type in that responsibility.
 */
protocol SpacingStrategy {
    
    /**
     Use the available methods to space the tabs appropriately.
     */
    func layout(tabs: [Tab], tabBar: TabBar_VC)
}

extension SpacingStrategy {
    
    /**
     Positions tabs by placing them one after the other (from left to right), applying the given padding between each tab.
     
     - Parameter padding: The amount of padding to apply between tabs.
     Pass 0 for tabs to be placed next to each other with no gaps.
     
     - Parameter startPadding: The amount of padding to be applied before the first tab is placed.
     
     Tabs are only spaced (positioned horizontally); they are not positioned vertically.
     
     */
    func space(tabs: [Tab], padding: CGFloat, startPadding: CGFloat) {
        
        // For vertical positioning, the superview needs to be given, so we can center them vertically using the height of it.
        // But then, we might as well add them as subviews to the passed in superview.
        // Don't get into vertical placement, because then it's no longer spacing; it becomes positioning and adding as subviews.
        
        var x: CGFloat = startPadding
        
        for each in tabs {
            each.frame.origin.x = x
            x += each.bounds.width
            x += padding
            
            // DEBUG
//            each.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        }
        
        
    }
    
    /**
     Returns the collective width of all tabs, including the widths of the specified padding between them.
     
     - Parameter padding: The amount of padding between tabs, whose width should be applied to the final result.
     Note that n tabs will have n - 1 paddings. Pass 0 to return the collective width of only the tabs.
     */
    func collectiveWidth(tabs: [Tab], padding: CGFloat) -> CGFloat {
        
        var total: CGFloat = 0
        
        for each in tabs {
            total += each.bounds.width
        }
        
        total += CGFloat(tabs.count - 1) * padding
        
        return total
    }
}
