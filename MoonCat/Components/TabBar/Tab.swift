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
        
        // Don't use autolayout here; a subclass may want to animate these views.
        // If you don't provide the constraints, that won't be possible.
        // And even if you do, frame based animation won't be possible.
        // So lay them out by frame, and provide a recenter method to be called by layout styles that resize the tab.
        
        super.init(frame: activeImage.bounds)
        
        self.addSubview(activeImage)
        self.addSubview(inactiveImage)

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Provided so that layout styles that resize the tab can have their active and inactive imageviews recentered.
     For subclasses that wish to keep the default positioning by not establishing any new positioning, this method must be called
     by layout styles that change the size, after the size has been changed.
     
     Problem:
     Subclasses that wish to have a 'different' position, and not animate that, and use a style that changes size,
     will experience the problem of their desired positioning being overwritten.
     
     Don't allow override inits? So that chrome elements are added in another method.
     Then, the init will have the default positioning.
     And your chrome will be added in another method, which may also reposition the base views / apply constraints to them.
     But note that if you position things by frame here, a layout style that resizes things WILL mess up that layout.
     How to avoid that?
     Have the layout style do its job before that function is called.
     
     But, we also want to ensure the layout style can't mess up the default positioning, if the default is desired.
     Without manually calling that recenter method after.
     
     So, have the default positioning be applied after the layout style does its job, then have a different method
     called (where the subclass sets up their chrome / uses their own positioning).
     
     Layout, then default positioning, then the subclass's method.
     Which means, the base init should not do any positioning; just create the views, store them and add them as subviews.
     The default method should then position them.
     Then the other method should be called, which subclasses need to override to add and layout their chrome, and
     change the default positioning if they want.
     
     The TabLayoutStyle is responsible for the layout of the tabs,
     so make this the object that does the layout, then sets the default positioning, then calls the setup.
     Or, since it's just the layout style, and the tab bar calls its layout method, have the tab bar perform these steps.
     
     */
    func recenter() {
        self.activeImage.center = self.midPoint
        self.inactiveImage.center = self.midPoint
    }
    
    
    /**
     
     */
    func layoutContent() {
        inactiveImage.center = self.midPoint
        activeImage.center = self.midPoint
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
