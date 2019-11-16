//
//  AnimationStrategy.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-10.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

/**
 Performs the transition animation between tabs in a TabBar.
 */
protocol AnimationStrategy {
    
    /** Animate the transition. Indices are provided to determine direction. */
    func animate(fromView: UIView, toView: UIView, fromIndex: Int, toIndex: Int)
}
