//
//  TabLayoutStyle.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-16.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

enum TabLayoutStyle {
    
    /** Lays out tabs to be collectively centered within the tab bar, with the specified inter-tab padding.
     Tabs keep their intrinsic size, and are vertically centered.
     */
    case center(padding: CGFloat)
    
    /** Lays out tabs to take up all the space, overriding their intrinsic size. */
    case fill
    
    /** Lays out tabs so that the space between consecutive tabs, as well as the space between end tabs and the tab bar, are all equal.
     Tabs keep their intrinsic size, and are vertically centered.
     */
    case equal
    
    /**
     Lays out tabs accordingly, depending on the style. All layout is performed; vertical, horizontal, and sizing if applicable.
     */
    func layout(tabs: [Tab], tabBar: TabBar_VC) {
        switch self {
        case .center(let p):
            // Determine the amount of free space after tabs and inter-tab padding
            // Half of that amount is the start padding

            let maxW = self.collectiveWidth(tabs: tabs, padding: p)
            let startX = (tabBar.view.bounds.width - maxW) / 2
            self.space(tabs: tabs, padding: p, startPadding: startX)
            self.centerVertically(tabs: tabs, tabBar: tabBar)

        case .fill:
            // Size the tabs equally to take up all the space
            // Space them with no gaps

            let w = tabBar.view.bounds.width / CGFloat(tabs.count)
            let h = tabBar.view.bounds.height
            let size = CGSize(width: w, height: h)

            for each in tabs {
                each.bounds.size = size
            }
            
            self.space(tabs: tabs, padding: 0, startPadding: 0)

        case .equal:
            // Determine the collective width of all tabs
            // Determine the left over space
            // Divide that space by number of tabs + 1

            let totalWidth = self.collectiveWidth(tabs: tabs, padding: 0)
            let leftover = tabBar.view.bounds.width - totalWidth
            let spacing = floor(leftover / CGFloat(tabs.count + 1))
            self.space(tabs: tabs, padding: spacing, startPadding: spacing)
            self.centerVertically(tabs: tabs, tabBar: tabBar)

        }
    }

    
    private func centerVertically(tabs: [Tab], tabBar: TabBar_VC) {
        for each in tabs {
            each.center.y = tabBar.view.bounds.height / 2
            each.frame = each.frame.integral
        }
    }
    
    /**
     Positions tabs by placing them one after the other (from left to right), applying the given padding between each tab.

     - Parameter padding: The amount of padding to apply between tabs.
     Pass 0 for tabs to be placed next to each other with no gaps.

     - Parameter startPadding: The amount of padding to be applied before the first tab is placed.

     Tabs are only spaced (positioned horizontally); they are not positioned vertically by this method.

     */
    private func space(tabs: [Tab], padding: CGFloat, startPadding: CGFloat) {

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
    private func collectiveWidth(tabs: [Tab], padding: CGFloat) -> CGFloat {

        var total: CGFloat = 0

        for each in tabs {
            total += each.bounds.width
        }

        total += CGFloat(tabs.count - 1) * padding

        return total
    }
}
