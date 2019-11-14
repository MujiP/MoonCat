//
//  TabBar.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-10.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

/**
 
 A class representing an overlay TabBar.
 Stores a collection of tabs and their associated views.
 Performs the parenting of a tab's vc on behalf of the parent, and manages its view, whose size will match the parent,
 and will be added to the bottom of the parent's view, hence overlay TabBar.
 Tab vc's are created lazily, and are retained between tab switches.
 
 When a tab is pressed, if self doesn't have a view, it'll vend a vc from the tab,
 parent it, retain the view, and passes an animator the old and new views.
 All the client has to do is, nothing.
 */
class TabBar: UIView {
    
    /*
        🈯️        💤        💤        💤     (Associated Views)
     
      Pressed     Not       Not       Not     (Tabs are like buttons)
     */
    
    var views = [Int: UIView]()
    var tabs = [Tab]()
    var atIndex: Int
    let parent: UIViewController
    let animator: AnimationStrategy
    
    /**
     Subclasses should layout their chrome elements here, after calling super.
     */
    init(config: [TabConfig],
         startIndex: Int,
         animationStrategy: AnimationStrategy,
         spacingStrategy: SpacingStrategy,
         parent: UIViewController,
         tabType: Tab.Type,
         height: CGFloat,
         y_origin: CGFloat) {
        
        self.parent = parent
        self.animator = animationStrategy
        self.atIndex = startIndex
        
        super.init(frame: CGRect(x: 0, y: y_origin, width: parent.view.bounds.width, height: height))
        
        // Create all the tabs, then pass them to the spacing strategy
        // Don't add tabs as subviews; allow the spacing strategy to do that.
        
        for i in 0..<config.count {
            let c = config[i]
            let tab = tabType.init(config: c, parent: self, index: i)
            self.tabs.append(tab)
        }
        
        spacingStrategy.layout(tabs: self.tabs, tabBar: self)
        vendIfNeeded(tab: tabs[startIndex])
        tabs[startIndex].press()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Creates the tab's vc, welcomes it on behalf of the parent, and retains the view.
     This method does nothing if a tab has already been vended before.
     */
    private func vendIfNeeded(tab: Tab) {
        let index = tab.index
        
        if self.views[index] != nil {
            return
        }
        
        let newVC = tab.vend()
        self.parent.welcomeChild(newVC, frame: self.parent.view.bounds, atIndex: 0)
        self.views[index] = newVC.view
        
        // Note: We put the new view right at the bottom, instead of below self.
        // This is because there may be a blur view in the parent view, that is right below self.
    }
    
    /**
     Called by Tabs when they enter the pressed state. This is not called for the starting tab.
     Subclasses can override to perform animation of their chrome elements. Must call super.
     */
    func tabWasPressed(_ tab: Tab) {
        
        vendIfNeeded(tab: tab)
        let index = tab.index
        
        tabs[atIndex].unpress()
        let toView = self.views[index]!
        let fromView = self.views[atIndex]!
        self.animator.animate(fromView: fromView, toView: toView, fromIndex: atIndex, toIndex: index)
        self.atIndex = index
    }
    
}
