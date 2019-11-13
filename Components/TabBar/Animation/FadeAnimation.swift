//
//  FadeAnimation.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-12.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

struct FadeAnimation: AnimationStrategy {
    func animate(fromView: UIView, toView: UIView, fromIndex: Int, toIndex: Int) {
        toView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            toView.alpha = 1
            fromView.alpha = 0
        }
    }
}
