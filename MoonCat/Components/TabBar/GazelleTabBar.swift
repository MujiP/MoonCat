//
//  GazelleTabBar_VC.swift
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
class GazelleTabBar_VC: TabBar_VC {
    
    var activeLine: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let l = UIView()
        l.backgroundColor = #colorLiteral(red: 0.2200894952, green: 0.4641377926, blue: 0.8669697642, alpha: 1)
        self.activeLine = l
        self.view.addSubview(l)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let startTab = self.tabs[self.atIndex]
        let l = self.activeLine!
        l.bounds.size.width = startTab.bounds.width - 27 // to negate the padding applied to assets
        l.bounds.size.height = 2
        l.center = startTab.center
        l.frame.origin.y = startTab.frame.origin.y + startTab.bounds.height - 16 // to negate some of the padding applied to assets
    }
    
    override func tabWasPressed(_ tab: Tab) {
        super.tabWasPressed(tab)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: [], animations: {
            self.activeLine.bounds.size.width = tab.bounds.width - 27
            self.activeLine.center.x = tab.center.x
        }, completion: nil)
    }
    
}
