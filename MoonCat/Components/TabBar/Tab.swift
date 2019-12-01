//
//  Tab.swift
//
//  Created by Muji Paracha on 2019-11-10.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

/**
 A Tab is like a push-once button.
 Subsequent presses have no effect.
 Alerts its TabBar when it is pressed.
 Can be told by the TabBar to become unpressed (when a different tab gets pressed)
 Switches between its 2 images for pressed and unpressed states.
 
 Has an associated VC, the same way you register a cell class for a tableView
 */
class Tab: UIView {
    
    let index: Int
    var isActive = false
    let activeImage: UIImageView
    let inactiveImage: UIImageView
    let type: UIViewController.Type
    weak var parent: TabBar_VC!
    
    /**
     Subclasses should override and call super, then add/store their additional chrome views.
     Constraint based layout can be done here as well. Don't perform frame based layout here.
     
     - Precondition: Images exist for both strings, and they should be the same size,
     as self is given a size to match one of them. Images should be large enough to be tapped.
     */
    required init(config: TabConfig, parent: TabBar_VC, index: Int) {
        
        // Note: Construction with a meta type (Tab.Type) needs to have a required initializer.
        
        let activeImage = UIImageView(image: UIImage(named: config.activeImageString))
        let inactiveImage = UIImageView(image: UIImage(named: config.inactiveImageString))
        self.activeImage = activeImage
        self.inactiveImage = inactiveImage
        
        self.index = index
        self.type = config.type
        self.parent = parent
        
        super.init(frame: activeImage.bounds)
        
//        self.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        
        self.addSubview(activeImage)
        self.addSubview(inactiveImage)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     A place to perform frame based layout of chrome elements, or change the default positioning of
     the active/inactive views.
     */
    func layoutContent() {
        self.inactiveImage.center = self.midPoint
        self.activeImage.center = self.midPoint
        
        self.inactiveImage.frame = self.inactiveImage.frame.integral
        self.activeImage.frame = self.activeImage.frame.integral
    }
    
    /**
     Subclasses should override to perform toggling logic on their additional chrome elements.
     Must call super.
     */
    func setImages() {
        
        if isActive {
            activeImage.alpha = 1
            inactiveImage.alpha = 0
        } else {
            inactiveImage.alpha = 1
            activeImage.alpha = 0
        }
    }
    
    @objc final func handleTap() {
        if isActive {
            return
        }
        pressAndNotify()
    }
    
    final func press() {
        isActive = true
        setImages()
    }
    
    final func pressAndNotify() {
        press()
        parent.tabWasPressed(self)
    }
    
    final func unpress() {
        isActive = false
        setImages()
    }
    
    final func vend() -> UIViewController {
        return type.init()
    }
    
}
