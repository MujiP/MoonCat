//
//  TabTransitionStyle.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-16.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

enum TabTransitionStyle {
    
    case fade, slide
    
    /** Performs the transition animation between tabs in a TabBar, according to the style.
     Indices are provided to determine direction if applicable.
     */
    func animate(fromView: UIView, toView: UIView, fromIndex: Int, toIndex: Int) {
        switch self {
        case .fade:
            toView.alpha = 0
            UIView.animate(withDuration: 0.2) {
                toView.alpha = 1
                fromView.alpha = 0
            }
            
        case .slide:
            if toIndex > fromIndex {
                // Animate everything left
                
                toView.frame.origin.x = toView.bounds.size.width
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: [], animations: {
                    toView.frame.origin.x = 0
                    fromView.frame.origin.x = -fromView.bounds.width
                }, completion: nil)
                
            } else {
                // Animate everything right
                
                toView.frame.origin.x = -toView.bounds.size.width
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: [], animations: {
                    toView.frame.origin.x = 0
                    fromView.frame.origin.x = fromView.bounds.width
                }, completion: nil)
            }
            
        }
    }
}
