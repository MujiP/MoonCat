//
//  X_UIViewController.swift
//
//  Created by Muji Paracha on 2019-10-26.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func welcomeChild(_ newVC: UIViewController, frame: CGRect) {
        
        // Performs the VC dance
        
        self.addChild(newVC)
        newVC.view.frame = frame
        self.view.addSubview(newVC.view)
        newVC.didMove(toParent: self)
        
    }
    
    func welcomeChild(_ newVC: UIViewController, frame: CGRect, below: UIView) {
        
        // Performs the VC dance
        // Precondition: below must be in the view hierarchy
        
        self.addChild(newVC)
        newVC.view.frame = frame
        self.view.insertSubview(newVC.view, belowSubview: below)
        newVC.didMove(toParent: self)
        
    }
    
    func welcomeChild(_ newVC: UIViewController, frame: CGRect, atIndex index: Int) {
        
        // Performs the VC dance
        // Precondition: below must be in the view hierarchy
        
        self.addChild(newVC)
        newVC.view.frame = frame
        self.view.insertSubview(newVC.view, at: index)
        newVC.didMove(toParent: self)
        
    }
    
    func leave() {
        
        // Performs the VC dance
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}
