//
//  SegmentedBar.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-25.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

/**
 A component that displays a segmented bar
 */
class SegmentedBar: UIView {
    
    private var fill: UIView
    private var lines = [UIView]()
    private var maxCount: Int
    private var currentCount: Int
    
    private var lineSize: CGSize!
    private var segmentWidth: CGFloat!
    
    init(currentCount: Int, maxCount: Int) {
        
        self.maxCount = maxCount
        self.currentCount = currentCount
        
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.2200894952, green: 0.4641377926, blue: 0.8669697642, alpha: 1)
        self.fill = v
        
        super.init(frame: CGRect.zero)
        self.backgroundColor = #colorLiteral(red: 0.679027617, green: 0.7697064281, blue: 0.9317507148, alpha: 1)

        
        self.addSubview(v)

        
        // Have the base layer be the
        // Have the fill layer be the middle layer
        // Have the segments on the top
        
        let numLines = maxCount - 1
        for _ in 1...numLines {
            let l = UIView()
            l.backgroundColor = UIColor.white
            self.addSubview(l)
            self.lines.append(l)
        }
        
    }
    
    override func layoutSubviews() {
        
        // Note: Don't layout views that are to be animated as well; layoutSubviews is called during an animation!
        
        self.lineSize = CGSize(width: 0.5, height: self.bounds.height)
        self.segmentWidth = self.bounds.width / CGFloat(self.maxCount)
        
        var x: CGFloat = segmentWidth
        for each in self.lines {
            each.bounds.size = lineSize
            each.frame.origin.x = x
            each.frame.origin.y = 0
            x += segmentWidth
        }
        
        self.fill.bounds.size.height = self.bounds.height
        self.fill.bounds.size.width = CGFloat(self.currentCount) * segmentWidth
        self.fill.frame.origin = CGPoint.zero
    }
    
    /**
     Fills up the bar by one segment.
     */
    func increment() {
        
        if self.currentCount == self.maxCount {
            // It's full
            return
        }
        
        self.currentCount += 1
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: [], animations: {
            self.fill.bounds.size.width = CGFloat(self.currentCount) * self.segmentWidth
        }, completion: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Drains the bar by one segment.
     */
    func decrement() {
        if self.currentCount == 0 {
            // It's empty
            return
        }
        
        self.currentCount -= 1
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: [], animations: {
            self.fill.bounds.size.width = CGFloat(self.currentCount) * self.segmentWidth
        }, completion: nil)
        
    }
    
}
