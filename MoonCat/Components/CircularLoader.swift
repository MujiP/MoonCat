//
//  CircularLoader.swift
//
//  Created by Muji Paracha on 2019-09-03.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

class CircularLoader: UIView {
    
    // TODO: why does leaving the app and coming back make the loader stop its animation without resuming?
    
    private var progressCircle: CAShapeLayer!
    
    init(color: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.setup(color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(color: UIColor) {
        // Faded Circle Layer
        let c = CAShapeLayer()
        let p = UIBezierPath(ovalIn: CGRect(x: -15, y: -15, width: 30, height: 30))
        c.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        c.position = self.midPoint
        c.path = p.cgPath
        c.strokeColor = color.cgColor
        c.fillColor = UIColor.clear.cgColor
        c.opacity = 0.4
        c.lineWidth = 2
        self.layer.addSublayer(c)
        
        // Progress Circle
        let d = CAShapeLayer()
        d.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        d.position = self.midPoint
        
        //        let p2 = UIBezierPath(ovalIn: CGRect(x: (self.view.bounds.width / 2) - 15, y: (self.view.bounds.height / 2) - 15, width: 30, height: 30))
        
        let p2 = UIBezierPath(ovalIn: CGRect(x: -15, y: -15, width: 30, height: 30))
        
        d.path = p2.cgPath
        d.strokeColor = color.cgColor
        d.lineWidth = 2
        d.fillColor = UIColor.clear.cgColor
        d.strokeEnd = 0.25
        d.lineCap = .round
        
        d.shadowColor = color.cgColor
        d.shadowOpacity = 0.5
        d.shadowRadius = 4
        self.progressCircle = d
        self.layer.addSublayer(d)
        
    }
    
    func start() {
        
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: [], animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
        let startValue = 0.0
        let endValue = 2 * Double.pi
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.duration = 0.7
        //        anim.timingFunction = CAMediaTimingFunction(name: .easeOut)
        anim.repeatCount = Float.infinity
        anim.fromValue = startValue
        anim.toValue = endValue
        self.progressCircle.add(anim, forKey: "rotate")
    }
    
    func stop(ch: () -> ()) {
        self.progressCircle.removeAllAnimations()
        ch()
        
//        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
//            self.alpha = 0
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: [], animations: {
//            self.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
//        }, completion: { _ in
//            ch()
//        })
    }

    
}




