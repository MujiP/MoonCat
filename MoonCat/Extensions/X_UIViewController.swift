//
//  X_UIViewController.swift
//
//  Created by Muji Paracha on 2019-10-26.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /**
     Performs the VC dance of adding a new child. The passed in block will receive the view.
     You can add it as a subview normally, or insert it at a particular index; however you like.
     And you can layout the view by frame or by activating constraints within the block.
     */
    func welcomeChild(_ newVC: UIViewController, _ ch: (UIView) -> ()) {
        self.addChild(newVC)
        ch(newVC.view)
        newVC.didMove(toParent: self)
    }
    
    /**
     Performs the VC dance of removing a child.
     */
    func leave() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}
