//
//  X_UIView.swift
//
//  Created by Muji Paracha on 2019-10-26.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

extension UIView {
    
    var midPoint: CGPoint {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }
    
    func pinTo(_ v: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: v.trailingAnchor),
            self.topAnchor.constraint(equalTo: v.topAnchor),
            self.bottomAnchor.constraint(equalTo: v.bottomAnchor)
        ])
    }
    
    var intrinsicWidthConstraint: NSLayoutConstraint {
        return self.widthAnchor.constraint(equalToConstant: self.bounds.width)
    }
    
    var intrinsicHeightConstraint: NSLayoutConstraint {
        return self.heightAnchor.constraint(equalToConstant: self.bounds.height)
    }
    
    // TODO:
    // Change these to use alpha property instead, so the call can be placed in an animation block.
    // Note that isHidden and alpha are not the same; a view that has alpha of 1 will not show if it was
    // set to be hidden.
    // And hidden is not animateable.
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
    
}
