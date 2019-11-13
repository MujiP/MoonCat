//
//  SlideAnimation.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-12.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

class SlideAnimation: AnimationStrategy {
    func animate(fromView: UIView, toView: UIView, fromIndex: Int, toIndex: Int) {
        
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
