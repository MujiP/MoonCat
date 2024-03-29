//
//  TabBar_VC.swift
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
 A tab's vc is created lazily, and is retained between tab switches.
 
 When a tab is pressed, if self doesn't have a view, it'll vend a vc from the tab,
 parent it, retain the view, and pass an animator the old and new views.
 All the client has to do is, nothing.
 */
class TabBar_VC: UIViewController {
    
    /*
        🈯️        💤        💤        💤     (Associated Views)
     
      Pressed     Not       Not       Not     (Tabs are like buttons)
     */
    
    private var views = [Int: UIView]()
    private let transitionStyle: TabTransitionStyle
    
    // These properties are marked as final so subclasses can still use them for positioning / animating chrome elements
    
    final var tabs = [Tab]()
    final var atIndex: Int
    final let layoutStyle: TabLayoutStyle
    
    init(config: [TabConfig],
         startIndex: Int,
         transitionStyle: TabTransitionStyle,
         layoutStyle: TabLayoutStyle,
         tabType: Tab.Type) {
        
        self.transitionStyle = transitionStyle
        self.atIndex = startIndex
        self.layoutStyle = layoutStyle
        
        super.init(nibName: nil, bundle: nil)
        
        // Add and store the tabs.
        // Layout will be done in viewDidAppear, when self's frame is guaranteed.
        
        for i in 0..<config.count {
            let c = config[i]
            let tab = tabType.init(config: c, parent: self, index: i)
            self.tabs.append(tab)
            self.view.addSubview(tab)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(toParent parent: UIViewController?) {
        vendIfNeeded(tab: tabs[atIndex])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // This is the best place to do initial placement by frame, when the main view is layed out with autolayout.
        // We want the tabs to be layed out depending on the frame of self, which may use auto layout, or may use a fixed frame,
        // so lay them out here, where the frame is accurate.
        
        // There may be frame dependant code in the tab's setImages method, so make sure layout is called before.
        self.layoutStyle.layout(tabs: self.tabs, tabBar: self)
        
        for each in tabs {
            each.layoutContent()
            each.unpress()
        }
        
        tabs[atIndex].press()
        
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
        self.parent!.welcomeChild(newVC) { (v) in
            v.frame = self.parent!.view.bounds
            self.parent!.view.insertSubview(v, at: 0)
        }
        
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
        self.transitionStyle.animate(fromView: fromView, toView: toView, fromIndex: atIndex, toIndex: index)
        self.atIndex = index
    }
    
}
